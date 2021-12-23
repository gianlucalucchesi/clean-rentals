package com.cleanrentals.api.exceptions;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(HttpStatus.CONFLICT)
public class ConflictException extends Exception {
    public ConflictException(String message) {
        super(message);
        log(message);
    }

    private void log(String message) {
        System.out.println(message);
    }
}
