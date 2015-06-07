#include "Scene.h"

Scene::Scene(){
	phongShader.load("shaders/phong_vert.glsl", "shaders/phong_frag.glsl");
}

void Scene::setLight(const ofLight& _light){
	light = _light;
	light.setPosition(_light.getPosition());
}

void Scene::setMaterial(ofMaterial _material){
	material = _material;
}

void Scene::begin(){
	phongShader.begin();
		ofVec3f p = light.getPosition();
		phongShader.setUniform3f("lightPosition", p.x, p.y, p.z);
		// Set light uniforms
		ofFloatColor c(light.getAmbientColor());
		phongShader.setUniform3f("light.color", c.r, c.g, c.b);
		phongShader.setUniform1f("light.power", 1.0);
		// Set material uniforms
		ofFloatColor ac(material.getAmbientColor());
		phongShader.setUniform3f("material.ambient", ac.r, ac.g, ac.b);
		ofFloatColor dc(material.getDiffuseColor());
		phongShader.setUniform3f("material.diffuse", dc.r, dc.g, dc.b);
		ofFloatColor sc(material.getSpecularColor());
		phongShader.setUniform3f("material.specular", sc.r, sc.g, sc.b);
		phongShader.setUniform1f("material.shininess", material.getShininess());
}

void Scene::end(){
	phongShader.end();
}