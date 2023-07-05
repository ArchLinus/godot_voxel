#[compute]
#version 450

layout (local_size_x = 4, local_size_y = 4, local_size_z = 4) in;

layout (set = 0, binding = 0, std430) restrict readonly buffer Params {
	vec3 origin_in_voxels;
	float voxel_size;
	ivec3 block_size;
} u_params;

// <PLACEHOLDER>

layout (set = 0, binding = 1, std430) restrict writeonly buffer OutSDBuffer {
	float values[];
} u_out_sd;

void generate(vec3 pos, out float out_sd) {
}
// </PLACEHOLDER>

int get_zxy_index(ivec3 pos, ivec3 size) {
	return pos.y + size.y * (pos.x + size.x * pos.z);
}

void main() {
	const ivec3 rpos = ivec3(gl_GlobalInvocationID.xyz);
	// The output buffer might not have a 3D size multiple of our group size.
	// Some of the parallel executions will not do anything.
	if (rpos.x >= u_params.block_size.x || rpos.y >= u_params.block_size.y || rpos.z >= u_params.block_size.z) {
		return;
	}

	const int out_index = get_zxy_index(rpos, u_params.block_size);
	const vec3 wpos = u_params.origin_in_voxels + vec3(rpos) * u_params.voxel_size;
	// float sd = get_sd(wpos);
	// u_out_sd.values[out_index] = sd;

// <PLACEHOLDER>
	generate(wpos, u_out_sd.values[out_index]);
// </PLACEHOLDER>
}
