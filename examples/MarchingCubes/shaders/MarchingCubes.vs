// MarchingCubes.vs
#version 410

// texel-center coordinates for lower-left corner of voxel.
// uvCoord.x = (i+0.5)/gridWidth, i in [0,gridWidth-1].
// uvCoord.y = (j+0.5)/gridHeight, j in [0,gridHeight-1].
layout (location = 0) in vec2 uvCoord;

// texel-center coordinate for z texture layer
// zLayer = (i+0.5)/gridDepth, i in [0,gridDepth-1].
layout (location = 1) in float zLayer;

uniform sampler3D volumeData;
uniform float gridWidth;
uniform float gridHeight;
uniform float gridDepth;
uniform float isoSurfaceThreshold;

out vsOutputGsInput {
	vec3 wsPosition; // World-space position of minimum corner of voxel.
	vec3 uvw; // Minimum corner of voxel, normalized texture coordinate.
	vec4 step; // voxel dimensions
	vec4 f0123; // Density values at all
	vec4 f4567; // ... 8 voxel corners.
	uint mc_case; // 0-255, edge table case.

} vs_out;

void main() {
	vec3 uvw = vec3(uvCoord, zLayer);
	vs_out.uvw = uvw;

	// Convert from texture-space to [-1..1] range in world-space.
	vs_out.wsPosition = (2.0 * uvw) - vec3(1.0);
	
	vec4 step = vec4(1.0/gridWidth, 1.0/gridHeight, 1.0/gridDepth, 0.0);
	vs_out.step = step;

	//	Sample lower level voxel corners:
	vs_out.f0123 = vec4( texture(volumeData, uvw).r,
						 texture(volumeData, uvw + step.xww).r,
						 texture(volumeData, uvw + step.xyw).r,
						 texture(volumeData, uvw + step.wyw).r );

	// Sample upper level voxel corners:
	vs_out.f4567 = vec4( texture(volumeData, uvw + step.wwz).r,
						 texture(volumeData, uvw + step.xwz).r,
						 texture(volumeData, uvw + step.xyz).r,
						 texture(volumeData, uvw + step.wyz).r );


	vec4 threshold = vec4(isoSurfaceThreshold);
	uvec4 n0123 = uvec4(1-step(threshold, vs_out.f0123));
	uvec4 n4567 = uvec4(1-step(threshold, vs_out.f4567));


	// Each bit corresponds a voxel corner.  A bit is turned on (1)
	// if it's corner is below the isoSurfaceThreshold, off (0) otherwise.
	vs_out.mc_case = (n0123.x) | (n0123.y << 1) | (n0123.z << 2) | (n0123.w << 3) |
				   (n4567.x << 4) | (n4567.y << 5) | (n4567.z << 6) | (n4567.w << 7);

}
