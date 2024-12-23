<?php

namespace App\Controller;

use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;

class TestController
{
    #[Route('/api/test', name: 'api_test', methods: ['GET', 'POST'])]
    public function test(): JsonResponse
    {
        return new JsonResponse(['message' => 'Communication successful!'], 200, ['Content-Type' => 'application/json']);
    }
}
