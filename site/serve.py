#!/usr/bin/env python3

import argparse
import os
from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer


class CleanURLRequestHandler(SimpleHTTPRequestHandler):
    """Serve VitePress clean URLs such as /getting-started."""

    def translate_path(self, path: str) -> str:
        translated = super().translate_path(path)

        if os.path.exists(translated):
            return translated

        html_path = f"{translated}.html"
        if os.path.isfile(html_path):
            return html_path

        return translated

    def send_error(self, code, message=None, explain=None):
        if code == 404:
            error_page = os.path.join(self.directory, "404.html")
            if os.path.isfile(error_page):
                with open(error_page, "rb") as file:
                    content = file.read()
                self.send_response(404)
                self.send_header("Content-Type", "text/html; charset=utf-8")
                self.send_header("Content-Length", str(len(content)))
                self.end_headers()
                if self.command != "HEAD":
                    self.wfile.write(content)
                return

        super().send_error(code, message, explain)


def main() -> None:
    parser = argparse.ArgumentParser(description="Serve the DAU Cloud Hub static site.")
    parser.add_argument("--bind", default="0.0.0.0", help="Address to bind to")
    parser.add_argument("--port", type=int, default=8080, help="Port to listen on")
    parser.add_argument("--directory", required=True, help="VitePress dist directory")
    args = parser.parse_args()

    handler = lambda *handler_args, **handler_kwargs: CleanURLRequestHandler(
        *handler_args,
        directory=args.directory,
        **handler_kwargs,
    )

    server = ThreadingHTTPServer((args.bind, args.port), handler)
    print(f"Serving DAU Cloud Hub on http://{args.bind}:{args.port}", flush=True)

    try:
        server.serve_forever()
    except KeyboardInterrupt:
        pass
    finally:
        server.server_close()


if __name__ == "__main__":
    main()
