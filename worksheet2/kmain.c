// kmain.c

// Packed struct without relying on stdint.h
struct example {
    unsigned char config;   // bits 0–7
    unsigned short address; // bits 8–23
    unsigned char index;    // bits 24–31
} __attribute__((packed));

int sum_of_three(int a, int b, int c) {
    return a + b + c;
}

void kmain(void) {
    // Simulate a 32-bit config value using an unsigned int
    unsigned int raw = 0xABCD1234;

    struct example* cfg = (struct example*)&raw;

    // Example usage of the struct (accessing fields)
    (void)cfg->config;
    (void)cfg->address;
    (void)cfg->index;
    
    // You can add more logic here
}
