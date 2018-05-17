Shader "Custom/NewSurfaceShader" {
	Properties{
		_Color("Main Color", Color) = (1,1,1,0.5)
		_SpecColor("Spec Color", Color) = (1,1,1,1)
		_Emission("Emmisive Color", Color) = (0,0,0,0)
		_Shininess("Shininess", Range(0.01, 1)) = 0.7
		_MainTex("Base (RGB)", 2D) = "white" { }
		_SubTex ("2nd Texure", 2D) = "white" { }
	}

	SubShader{
		Tags { "Queue" = "Transparent"}
		Pass{
			Blend SrcAlpha OneMinusSrcAlpha

			Material{
				Diffuse[_Color]
				Ambient[_Color]
				Shininess[_Shininess]
				Specular[_SpecColor]
				Emission[_Emission]
			}

			Lighting On
			SeparateSpecular On

			SetTexture[_MainTex]{
				Combine texture * primary DOUBLE
			}
			SetTexture[_SubTex]{
				constantColor[_Color]
				Combine texture lerp(texture) previous, constant
			}
		}
	}
}
