package com.bank.securebank.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.HashMap;
import java.util.Map;

@RestController
@CrossOrigin(origins = "*", allowedHeaders = "*", methods = {RequestMethod.GET, RequestMethod.POST, RequestMethod.PUT, RequestMethod.DELETE, RequestMethod.OPTIONS})
public class RootController {

    @GetMapping("/")
    public ResponseEntity<Map<String, Object>> root() {
        Map<String, Object> response = new HashMap<>();
        response.put("status", "success");
        response.put("message", "Secure Banking System API is running");
        response.put("version", "1.0.0");
        response.put("endpoints", Map.of(
            "health", "/api/health",
            "auth", "/api/auth",
            "docs", "/api/docs"
        ));
        response.put("timestamp", System.currentTimeMillis());
        return ResponseEntity.ok(response);
    }
}
