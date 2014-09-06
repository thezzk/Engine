#ifndef SPOT_LIGHT_H
#define SPOT_LIGHT_H

#include "PointLight.h"

class SpotLight : public PointLight
{
public:
  SpotLight(glm::vec3 color, float intensity, float range, float cutoff, Attenuation *attenuation);

  virtual void updateShader(Shader *shader);

  float getCutoff(void);

private:
  float m_cutoff;
};

#endif
