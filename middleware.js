export const config = {
  matcher: ["/dashboard.html"],
};

export default function middleware(request) {
  const auth = request.headers.get("authorization");

  if (auth) {
    const [, encoded] = auth.split(" ");
    try {
      const decoded = atob(encoded);
      const [user, ...passParts] = decoded.split(":");
      const pass = passParts.join(":");
      if (user === "Jem Joy" && pass === "dodosi") {
        return undefined;
      }
    } catch (e) {}
  }

  return new Response("Accès refusé", {
    status: 401,
    headers: {
      "WWW-Authenticate": 'Basic realm="Dashboard Jem Joy"',
      "Content-Type": "text/plain; charset=utf-8",
    },
  });
}
