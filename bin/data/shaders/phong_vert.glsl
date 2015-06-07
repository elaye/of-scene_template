#version 330

in vec4 position;
in vec4 normal;

out vec3 varyingNormal;
out vec3 eyeDirection;
out vec3 lightDirection;

uniform mat4 modelViewProjectionMatrix;
uniform mat4 modelViewMatrix;

uniform vec3 lightPosition;

void main(){

	gl_Position =  modelViewProjectionMatrix * position;
	
	// Vertex position in camera space
	vec3 pos = (modelViewMatrix * position).xyz;
	// Vector that goes from the vertex to the camera, in camera space.
	// In camera space, the camera is at the origin (0,0,0).
	eyeDirection = vec3(0.0) - pos;

	// Vector that goes from the vertex to the light, in camera space
	// lightDirection = (viewMatrix * vec4(lightDirection_inv, 0.0)).xyz;
	lightDirection = normalize((modelViewMatrix * vec4(lightPosition, 1.0)).xyz - pos);
	
	// Normal of the the vertex, in camera space
	varyingNormal = (modelViewMatrix * vec4(normal.xyz, 0.0)).xyz; // Only correct if ModelMatrix does not scale the model ! Use its inverse transpose if not.
}
