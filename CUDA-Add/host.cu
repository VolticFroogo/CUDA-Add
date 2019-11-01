#include "host.cuh"

int* Host::Add(int* a, int* b, int n, size_t size)
{
	// Allocate memory for the sums on the host.
	int* c = (int*)malloc(size);

	// Start the clock.
	auto start = std::chrono::high_resolution_clock::now();

	// Iterate through every value in the array.
	for (int i = 0; i < n; i++)
	{
		// Set C to the sum of A and B.
		c[i] = a[i] + b[i];
	}

	// Calculate the time of execution.
	auto finish = std::chrono::high_resolution_clock::now();
	auto delta = std::chrono::duration_cast<std::chrono::nanoseconds>(finish - start).count();

	// Print the time the host took to complete all of the addition.
	printf("Host exec time:   %llu ns\n", delta);

	return c;
}
