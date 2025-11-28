use tiny_http::{Server, Response, Header};
use std::process::Command;
use urlencoding;

fn cors_headers() -> Vec<Header> {
    vec![
        Header::from_bytes(&b"Access-Control-Allow-Origin"[..], &b"*"[..]).unwrap(),
        Header::from_bytes(&b"Access-Control-Allow-Methods"[..], &b"GET, POST"[..]).unwrap(),
        Header::from_bytes(&b"Access-Control-Allow-Headers"[..], &b"*"[..]).unwrap(),
    ]
}

fn respond_ok(req: tiny_http::Request, body: &str) {
    let mut resp = Response::from_string(body);
    for h in cors_headers() {
        resp.add_header(h);
    }
    req.respond(resp).unwrap();
}

fn respond_not_found(req: tiny_http::Request, body: &str) {
    let mut resp = Response::from_string(body).with_status_code(404);
    for h in cors_headers() {
        resp.add_header(h);
    }
    req.respond(resp).unwrap();
}

fn main() {
    println!("J'Core Native Launcher running on http://127.0.0.1:21112");

    let server = Server::http("127.0.0.1:21112").unwrap();

    for request in server.incoming_requests() {
        let url = request.url().to_string(); 

        if url.starts_with("/run?app=") {
            let encoded = url.trim_start_matches("/run?app=");
            let decoded = urlencoding::decode(encoded)
                .unwrap_or_else(|_| encoded.into())
                .to_string();

            let result = Command::new(&decoded).spawn();

            if result.is_ok() {
                respond_ok(request, "OK");
            } else {
                respond_not_found(request, "Failed to launch app");
            }
            
            continue;
        }

        respond_not_found(request, "Invalid route");
    }
}
