package tz.co.itrust.services.template.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

/**
 * Sample REST controller for Template Service
 */
@RestController
@RequestMapping("/api/v1")
public class HelloController {
    
    @GetMapping("/hello")
    public Map<String, Object> hello() {
        Map<String, Object> response = new HashMap<>();
        response.put("message", "Hello from Template Service!");
        response.put("timestamp", System.currentTimeMillis());
        response.put("service", "microservice-template");
        return response;
    }
    
    @GetMapping("/health")
    public Map<String, Object> health() {
        Map<String, Object> response = new HashMap<>();
        response.put("status", "UP");
        response.put("service", "microservice-template");
        return response;
    }
}
