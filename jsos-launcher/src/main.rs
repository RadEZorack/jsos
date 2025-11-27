use std::collections::HashMap;
use std::process::Command;
use tiny_http::{Server, Response};

fn main() {
    let apps = app_map();

    println!("J'Core Native Launcher running on http://127.0.0.1:21112");

    let server = Server::http("127.0.0.1:21112")
        .expect("Failed to bind HTTP server");

    for request in server.incoming_requests() {
        let url = request.url().to_string();

        if url.starts_with("/run?app=") {
            let app = url.split_once("=").unwrap().1;

            if let Some(cmd) = apps.get(app) {
                println!("Launching app: {}", cmd);

                let result = Command::new(cmd)
                    .envs(std::env::vars()) // inherit environment
                    .spawn();

                match result {
                    Ok(_) => {
                        request.respond(Response::from_string("OK")).ok();
                    }
                    Err(e) => {
                        let msg = format!("ERROR launching {}: {}", app, e);
                        eprintln!("{}", msg);
                        request
                            .respond(Response::from_string(msg).with_status_code(500))
                            .ok();
                    }
                }

                continue;
            }

            request
                .respond(Response::from_string("Unknown app").with_status_code(404))
                .ok();
            continue;
        }

        request
            .respond(Response::from_string("Not found").with_status_code(404))
            .ok();
    }
}

fn app_map() -> HashMap<&'static str, &'static str> {
    let mut map = HashMap::new();

    map.insert("firefox", "/usr/bin/firefox");
    map.insert("foot", "/usr/bin/foot");
    map.insert("settings", "gnome-control-center");
    map.insert("sublime", "/usr/bin/subl");

    map
}
