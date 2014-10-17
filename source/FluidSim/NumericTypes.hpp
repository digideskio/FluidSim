#ifndef FLUIDSIM_NUMERIC_TYPES_HPP
#define FLUIDSIM_NUMERIC_TYPES_HPP

#define GLM_FORCE_RADIANS
#include <glm/glm.hpp>
#include <glm/gtc/quaternion.hpp>

namespace FluidSim {

//--------------------------------------------------------------------------------------
// Basic Types
//--------------------------------------------------------------------------------------
typedef signed char byte;
typedef unsigned char ubyte;

typedef signed char	int8;
typedef signed short int16;
typedef signed int int32;

typedef unsigned char uint8;
typedef unsigned short uint16;
typedef unsigned int uint32;

typedef float float32;
typedef double float64;

//--------------------------------------------------------------------------------------
// GLM Types
//--------------------------------------------------------------------------------------
typedef glm::vec2 vec2;
typedef glm::vec3 vec3;
typedef glm::vec4 vec4;

typedef glm::mat2 mat2;
typedef glm::mat3 mat3;
typedef glm::mat4 mat4;

typedef glm::quat quat;

template <typename T>
using tvec2 = glm::detail::tvec2<T, glm::highp>;

template <typename T>
using tvec3 = glm::detail::tvec3<T, glm::highp>;

template <typename T>
using tvec4 = glm::detail::tvec4<T, glm::highp>;

template <typename T>
using tmat2 = glm::detail::tmat2x2<T, glm::highp>;

template <typename T>
using tmat3 = glm::detail::tmat3x3<T, glm::highp>;

template <typename T>
using tmat4 = glm::detail::tmat4x4<T, glm::highp>;


} // end namespace FluidSim

#endif /* FLUIDSIM_NUMERIC_TYPES_HPP */
