import { Request, Response, NextFunction } from 'express';
import { createClient } from 'redis';
import dotenv from 'dotenv';

dotenv.config();

const redisUrl = process.env.REDIS_URL || 'redis://localhost:6379';
export const redisClient = createClient({ url: redisUrl });

redisClient.on('error', (err) => console.error('Redis Client Error', err));

// Connect automatically (in a real prod app, you might await this at startup)
redisClient.connect().catch(console.error);

export const cacheMiddleware = (durationSeconds: number) => {
  return async (req: Request, res: Response, next: NextFunction) => {
    // Only cache GET requests
    if (req.method !== 'GET') {
      return next();
    }

    const key = `cache:${req.originalUrl || req.url}`;
    try {
      const cachedResponse = await redisClient.get(key);
      if (cachedResponse) {
        return res.json(JSON.parse(cachedResponse as string));
      } else {
        // Intercept response.send to cache it
        const originalSend = res.send.bind(res);
        res.send = (body: any) => {
          // Cache the response as a string
          const stringBody = typeof body === 'string' ? body : JSON.stringify(body);
          redisClient.setEx(key, durationSeconds, stringBody).catch(console.error);
          return originalSend(body);
        };
        next();
      }
    } catch (err) {
      console.error('Cache middleware error:', err);
      // Fail gracefully and continue if Redis is down
      next();
    }
  };
};
