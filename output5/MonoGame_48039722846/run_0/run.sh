#!/bin/bash

# Activate environment variables
export CI=true

# Install project dependencies (if any)
# Placeholder for any additional setup

# Run tests
cd tests-desktopgl

# Run all test suites, ensuring all tests are executed
set +e
dotnet MonoGame.Tests.dll --timeout=300000 --test MonoGame.Tests.Framework --where="Category != Audio"
dotnet MonoGame.Tests.dll --timeout=300000 --test MonoGame.Tests.Audio
dotnet MonoGame.Tests.dll --timeout=300000 --test MonoGame.Tests.Input
dotnet MonoGame.Tests.dll --timeout=300000 --test MonoGame.Tests.Visual
dotnet MonoGame.Tests.dll --timeout=300000 --where="Category = GameTest"
dotnet MonoGame.Tests.dll --timeout=300000 --test MonoGame.Tests.Graphics.BlendStateTest
dotnet MonoGame.Tests.dll --timeout=300000 --test MonoGame.Tests.Graphics.DepthStencilStateTest
dotnet MonoGame.Tests.dll --timeout=300000 --test MonoGame.Tests.Graphics.EffectTest
dotnet MonoGame.Tests.dll --timeout=300000 --test MonoGame.Tests.Graphics.GraphicsAdapterTest
dotnet MonoGame.Tests.dll --timeout=300000 --test MonoGame.Tests.Graphics.IndexBufferTest
dotnet MonoGame.Tests.dll --timeout=300000 --test MonoGame.Tests.Graphics.MiscellaneousTests
dotnet MonoGame.Tests.dll --timeout=300000 --test MonoGame.Tests.Graphics.ModelTest
dotnet MonoGame.Tests.dll --timeout=300000 --test MonoGame.Tests.Graphics.OcclusionQueryTest
dotnet MonoGame.Tests.dll --timeout=300000 --test MonoGame.Tests.Graphics.RasterizerStateTest
dotnet MonoGame.Tests.dll --timeout=300000 --test MonoGame.Tests.Graphics.RenderTarget2DTest
dotnet MonoGame.Tests.dll --timeout=300000 --test MonoGame.Tests.Graphics.RenderTargetCubeTest
dotnet MonoGame.Tests.dll --timeout=300000 --test MonoGame.Tests.Graphics.SamplerStateTest
dotnet MonoGame.Tests.dll --timeout=300000 --test MonoGame.Tests.Graphics.ScissorRectangleTest
dotnet MonoGame.Tests.dll --timeout=300000 --test MonoGame.Tests.Graphics.ShaderTest
dotnet MonoGame.Tests.dll --timeout=300000 --test MonoGame.Tests.Graphics.SpriteBatchTest
dotnet MonoGame.Tests.dll --timeout=300000 --test MonoGame.Tests.Graphics.SpriteFontTest
dotnet MonoGame.Tests.dll --timeout=300000 --test MonoGame.Tests.Graphics.Texture2DNonVisualTest
dotnet MonoGame.Tests.dll --timeout=300000 --test MonoGame.Tests.Graphics.Texture2DTest
dotnet MonoGame.Tests.dll --timeout=300000 --test MonoGame.Tests.Graphics.Texture3DNonVisualTest
dotnet MonoGame.Tests.dll --timeout=300000 --test MonoGame.Tests.Graphics.Texture3DTest
dotnet MonoGame.Tests.dll --timeout=300000 --test MonoGame.Tests.Graphics.TextureCubeTest
dotnet MonoGame.Tests.dll --timeout=300000 --test MonoGame.Tests.Graphics.VertexBufferTest
dotnet MonoGame.Tests.dll --timeout=300000 --test MonoGame.Tests.Graphics.ViewportTest
set -e