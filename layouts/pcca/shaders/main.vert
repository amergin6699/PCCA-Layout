uniform vec4 vertdatas;
uniform vec2 pivot;
uniform float depth;
varying vec3 v_uvp;

void main()
{
    vec2 pos = gl_Vertex.xy - pivot;
    vec3 p3  = vec3(pos, 0.0);

    float cx = cos(vertdatas.x), sx = sin(vertdatas.x);
    float y1 = cx * p3.y - sx * p3.z;
    float z1 = sx * p3.y + cx * p3.z;

    float cy = cos(vertdatas.y), sy = sin(vertdatas.y);
    float x2 = cy * p3.x + sy * z1;
    float z2 = -sy * p3.x + cy * z1;

    float p = 1.0 + z2 * depth;
    vec2 final = vec2(x2, y1) / p + pivot;

    gl_Position = gl_ModelViewProjectionMatrix * vec4(final, 0.0, 1.0);
    vec2 baseUV = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
    v_uvp = vec3(baseUV, 1.0) / p;

    gl_FrontColor = gl_Color;
}
