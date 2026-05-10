package com.bank.securebank.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/health")
@CrossOrigin(origins = "*", allowedHeaders = "*", methods = {RequestMethod.GET, RequestMethod.POST, RequestMethod.PUT, RequestMethod.DELETE, RequestMethod.OPTIONS})
public class HealthController {

    @GetMapping
    public ResponseEntity<Map<String, Object>> health() {
        Map<String, Object> response = new HashMap<>();
        response.put("status", "UP");
        response.put("service", "Secure Banking API");
        response.put("version", "1.0.0");
        response.put("timestamp", System.currentTimeMillis());
        response.put("environment", "production");
        
        return ResponseEntity.ok(response);
    }

    @GetMapping("/check")
    public ResponseEntity<Map<String, Object>> detailedHealth() {
        Map<String, Object> response = new HashMap<>();
        response.put("status", "UP");
        response.put("service", "Secure Banking API");
        response.put("version", "1.0.0");
        response.put("timestamp", System.currentTimeMillis());
        response.put("environment", "production");
        response.put("database", "Connected");
        response.put("endpoints", Map.of(
            "health", "/api/health",
            "auth", "/api/auth",
            "account", "/api/account",
            "transactions", "/api/transactions"
        ));
        
        return ResponseEntity.ok(response);
    }
}
