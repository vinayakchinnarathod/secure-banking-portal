package com.bank.securebank.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/error")
@CrossOrigin(origins = "*", allowedHeaders = "*", methods = {RequestMethod.GET, RequestMethod.POST, RequestMethod.PUT, RequestMethod.DELETE, RequestMethod.OPTIONS})
public class ErrorController {

    @GetMapping
    public ResponseEntity<Map<String, Object>> handleError() {
        Map<String, Object> response = new HashMap<>();
        response.put("status", "error");
        response.put("message", "Access denied or resource not found");
        response.put("timestamp", System.currentTimeMillis());
        return ResponseEntity.ok(response);
    }
}
