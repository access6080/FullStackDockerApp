package com.fullstackdockerapp;

import org.springframework.web.bind.annotation.*;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/api/v1/name")
public class Controller {

    @GetMapping("/{name}")
    public String getName(@PathVariable String name) {
        return "Hello " + name;
    }
}
