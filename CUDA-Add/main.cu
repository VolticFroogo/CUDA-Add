#include "main.cuh"

int main()
{
	// Define the size constants.
	const int n = 32000000;
	const size_t size = n * sizeof(int);

	// Allocate memory to for our large arrays.
	// We need to alloc instead of just defining a variable as the
	// call stack would be too big otherwise and throw an error.
	int* a = (int*)malloc(size);
	int* b = (int*)malloc(size);

	// Set all of the a values to 5 and b values to 7.
	for (int i = 0; i < n; i++)
	{
		a[i] = 5;
		b[i] = 7;
	}

	// Run the addition on the CPU (host).
	int* host = Host::Add(a, b, n, size);

	// Print a response from the host.
	printf("Host value:       %d\n\n", host[0]);

	// Run the addition on the GPU (device).
	int* device = Device::Add(a, b, n, size);

	// Print a response from the device.
	printf("Device value:     %d\n", device[n-1]);

	// Free the memory that we allocated.
	free(a);
	free(b);
	free(host);
	free(device);

    return 0;
}
