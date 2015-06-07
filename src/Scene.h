#pragma once

#include "ofMain.h"

#include "Scene.h"

class Scene {

	ofShader phongShader;

	ofLight light;
	ofMaterial material;

	public:
		Scene();

		void begin();
		void end();
		
		void setLight(const ofLight& light);
		void setMaterial(ofMaterial material);
};