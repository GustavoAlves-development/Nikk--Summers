import { isIP } from "node:net";
import { NextResponse, type NextRequest } from "next/server";

const API_URL = "https://ariseapp.com.br/api/v1/meta-ips/check";

type MetaIpResult = { is_meta: boolean };

function visitorIp(request: NextRequest): string | null {
  const forwarded = request.headers.get("x-forwarded-for");
  const ip = forwarded?.split(",", 1)[0]?.trim();
  return ip && isIP(ip) ? ip : null;
}

function isMetaIpResult(value: unknown): value is MetaIpResult {
  if (typeof value !== "object" || value === null) return false;
  return typeof (value as Partial<MetaIpResult>).is_meta === "boolean";
}

export async function proxy(request: NextRequest) {
  if (request.nextUrl.pathname !== "/" || !["GET", "HEAD"].includes(request.method)) {
    return NextResponse.next();
  }

  const ip = visitorIp(request);
  const token = process.env.ARISE_META_IPS_TOKEN;
  const redirectUrl = process.env.META_REDIRECT_URL;
  if (!ip || ip === "::1" || ip.startsWith("127.") || !token || !redirectUrl) {
    return NextResponse.next();
  }

  try {
    const response = await fetch(API_URL, {
      method: "POST",
      headers: {
        Authorization: `Bearer ${token}`,
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ ip }),
      signal: AbortSignal.timeout(5000),
      cache: "no-store",
    });

    if (!response.ok) return NextResponse.next();
    const result: unknown = await response.json();
    if (!isMetaIpResult(result) || !result.is_meta) return NextResponse.next();

    const target = new URL(redirectUrl);
    if (target.protocol !== "https:" || target.href === request.nextUrl.href) {
      return NextResponse.next();
    }

    const redirect = NextResponse.redirect(target);
    redirect.headers.set("Cache-Control", "private, no-store");
    return redirect;
  } catch {
    return NextResponse.next();
  }
}

export const config = { matcher: "/" };
