void puti(int i){
	*(volatile int*)0x10000000 = i;
}

void *memcpy(void *dest, const void *src, int n){
	while (n) {
		n--;
		((char*)dest)[n] = ((char*)src)[n];
	}
	return dest;
}

void *memset (void *dest, int val, int len){
	
  char *ptr = (char*)dest;
  while (len-- > 0)
    *ptr++ = val;
  return dest;
}


int mod(int dividend, int divisor) {
    // Handle division by zero
    if (divisor == 0) {
        return dividend;
    }
    
    // Calculate remainder using repeated subtraction
    int remainder = dividend;
    if (divisor > 0) {
        while (remainder >= divisor) {
            remainder -= divisor;
        }
        while (remainder < 0) {
            remainder += divisor;
        }
    } else { // Handle negative divisors
        while (remainder <= divisor) {
            remainder -= divisor;
        }
        while (remainder > 0) {
            remainder += divisor;
        }
    }
    
    return remainder;
}

int gcd(int a, int b)
{
	int temp = 0;
	int c = 0;
	while(b!=0) {
		temp = b;
		c = mod(a,b);
		b = c;
		a = temp;
	}
	return a;
}


void main() 
{ 
	int a = 96, b = 3;
	int c;
	
	c = gcd(a, b);
	puti(c);
	//printf("%d",c);
	
}

