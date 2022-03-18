package com.nayron.springawslambda.application;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.events.S3Event;

public class ServiceHandler implements RequestHandler<S3Event, String> {

    public ServiceHandler() {
        System.out.println("Teste Hello World!!!");
    }

    @Override
    public String handleRequest(S3Event input, Context context) {
        context.getLogger().log("Hello World");
        return "Hello";
    }
}
