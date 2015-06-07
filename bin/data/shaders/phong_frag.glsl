#version 330

struct Material {
	vec3 diffuse;
	vec3 ambient;
	vec3 specular;
	float shininess;	
};

struct Light {
	vec3 color;
	float power;
};

in vec3 varyingNormal;
in vec3 eyeDirection;
in vec3 lightDirection;

out vec4 color;

uniform mat4 modelViewMatrix;

uniform Material material;
uniform Light light;


void main(){

	// // Normal of the computed fragment, in camera space
	vec3 n = normalize(varyingNormal);
	// // Direction of the light (from the fragment to the light)
	vec3 l = normalize(lightDirection);
	// // Cosine of the angle between the normal and the light direction, 
	// // clamped above 0
	// //  - light is at the vertical of the triangle -> 1
	// //  - light is perpendiular to the triangle -> 0
	// //  - light is behind the triangle -> 0
	float cosTheta = clamp(dot(n, l), 0.0, 1.0);
	
	// Eye vector (towards the camera)
	vec3 E = normalize(eyeDirection);
	// Direction in which the triangle reflects the light
	vec3 R = normalize(-reflect(l,n));
	// Cosine of the angle between the Eye vector and the Reflect vector,
	// clamped to 0
	//  - Looking into the reflection -> 1
	//  - Looking elsewhere -> < 1
	float cosAlpha = clamp(dot(E, R), 0.0, 1.0);

	// Ambient
	vec3 a = material.ambient;
	// Diffuse
	vec3 d = material.diffuse * light.color * light.power * cosTheta;
	// Specular
	vec3 s = material.specular * light.color * light.power * pow(cosAlpha, material.shininess);

	vec3 linearColor = a + d + s;
	vec3 gamma = vec3(1.0/2.2);
	color = vec4(pow(linearColor, gamma), 1.0);	
}