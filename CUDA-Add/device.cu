#include "device.cuh"

int* Device::Add(int* a, int* b, int n, size_t size)
{
	// Declare the device pointers.
	int* devA, * devB, * devC;

	// Allocate memory on the device.
	cudaMalloc(&devA, size);
	cudaMalloc(&devB, size);
	cudaMalloc(&devC, size);

	// Copy A and B from the host onto the device.
	cudaMemcpy(devA, a, size, cudaMemcpyHostToDevice);
	cudaMemcpy(devB, b, size, cudaMemcpyHostToDevice);

	// Start the clock.
	auto start = std::chrono::high_resolution_clock::now();

	// Run the addition on the GPU (device).
	Kernel<<<31250, 1024>>>(devA, devB, devC, n);

	// Wait until all threads have finished.
	cudaDeviceSynchronize();

	// Calculate the time of execution.
	auto finish = std::chrono::high_resolution_clock::now();
	auto delta = std::chrono::duration_cast<std::chrono::nanoseconds>(finish - start).count();

	// Print the time the device took to complete all of the addition.
	printf("Device exec time: %llu ns\n", delta);

	// Copy the values back from the device to the host.
	int* c = (int*)malloc(size);
	cudaMemcpy(c, devC, size, cudaMemcpyDeviceToHost);

	// Free all of the device's memory.
	cudaFree(devA);
	cudaFree(devB);
	cudaFree(devC);

	return c;
}

__global__ void Device::Kernel(int* a, int* b, int* c, int n)
{
	int i = (blockIdx.x * blockDim.x) + threadIdx.x;

	// Set C to the sum of A and B.
	c[i] = a[i] + b[i];
}
