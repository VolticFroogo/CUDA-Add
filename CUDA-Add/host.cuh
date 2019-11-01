#pragma once

#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>
#include <stdlib.h>
#include <chrono>

namespace Host
{
	int* Add(int* a, int* b, int n, size_t size);
};
