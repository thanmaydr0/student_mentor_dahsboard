// A lightweight, browser-compatible Circuit Breaker

export class CircuitBreaker<TArgs extends any[], TResult> {
  private failureCount = 0;
  private lastFailureTime: number | null = null;
  private resetTimeout: number;
  private failureThreshold: number;
  private action: (...args: TArgs) => Promise<TResult>;
  private fallbackAction?: () => TResult | never;

  constructor(
    action: (...args: TArgs) => Promise<TResult>, 
    options: { resetTimeout: number, failureThreshold: number }
  ) {
    this.action = action;
    this.resetTimeout = options.resetTimeout;
    this.failureThreshold = options.failureThreshold;
  }

  fallback(fallbackAction: () => TResult | never) {
    this.fallbackAction = fallbackAction;
  }

  async fire(...args: TArgs): Promise<TResult> {
    const now = Date.now();
    
    // Check if circuit is OPEN
    if (this.failureCount >= this.failureThreshold) {
      if (this.lastFailureTime && now - this.lastFailureTime < this.resetTimeout) {
        // Circuit is still open
        if (this.fallbackAction) {
          return this.fallbackAction();
        }
        throw new Error("Circuit breaker is OPEN");
      } else {
        // Half-open state: allow one request to pass through
        // If it fails, it trips again. If it succeeds, it resets.
      }
    }

    try {
      const result = await this.action(...args);
      // Success, reset circuit (Closed state)
      this.failureCount = 0;
      this.lastFailureTime = null;
      return result;
    } catch (error) {
      this.failureCount++;
      this.lastFailureTime = Date.now();
      
      // If we just tripped the circuit, fire the fallback
      if (this.failureCount >= this.failureThreshold && this.fallbackAction) {
        return this.fallbackAction();
      }
      
      throw error; // Normal error before threshold
    }
  }
}
