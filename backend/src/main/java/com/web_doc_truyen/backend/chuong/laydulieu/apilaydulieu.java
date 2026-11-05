package com.web_doc_truyen.backend.chuong.laydulieu;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/api/laydulieu")
public class apilaydulieu {

    @Autowired
    private interlaydulieu itt;

    @GetMapping("/all")
    public ResponseEntity<?> all() {
        Map<String, Object> response = new HashMap<>();
        response.put("data", itt.findAll());
        return ResponseEntity.ok(response);
    }
}
