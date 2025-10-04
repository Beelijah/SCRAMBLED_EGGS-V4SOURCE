#version 330 core // Specify the GLSL version (adjust as needed for your OpenGL context)

out vec4 FragColor; // Declare the output variable for the fragment color

void main()
{
    FragColor = vec4(1.0, 0.0, 0.0, 1.0); // Set the color to opaque red (R, G, B, A)
}