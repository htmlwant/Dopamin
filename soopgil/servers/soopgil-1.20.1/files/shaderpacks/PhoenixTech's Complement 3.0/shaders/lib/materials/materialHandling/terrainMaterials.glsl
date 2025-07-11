#include "/lib/shaderSettings/materials.glsl"
#include "/lib/shaderSettings/water.glsl"
#include "/lib/shaderSettings/blueScreen.glsl"
#include "/lib/shaderSettings/emissiveFlowers.glsl"

if (mat >= 10000) {
if (mat < 11024) {
    if (mat < 10512) {
        if (mat < 10256) {
            if (mat < 10126) { // MV: Normal Mycelium
                if (mat < 10064) {
                    if (mat < 10032) {
                        if (mat < 10014) { // MV: Foliage
                            if (mat < 10006) { // MV: Leaves
                                if (mat < 10002) { // No directional shading, MV: Flowers
                                    noDirectionalShading = true;

                                    sandNoiseIntensity = 0.4, mossNoiseIntensity = 0.0, isFoliage = true;
                                }
                                else /*if (mat < 10006)*/ { // Grounded Waving Foliage
                                    subsurfaceMode = 1, noSmoothLighting = true, noDirectionalShading = true;

                                    #ifdef GBUFFERS_TERRAIN
                                        DoFoliageColorTweaks(color.rgb, shadowMult, snowMinNdotU, viewPos, nViewPos, lViewPos, dither);

                                        #ifdef COATED_TEXTURES
                                            doTileRandomisation = false;
                                        #endif
                                    #endif

                                    #if SHADOW_QUALITY == -1
                                        shadowMult *= 1.0 - 0.3 * (signMidCoordPos.y + 1.0) * (1.0 - abs(signMidCoordPos.x))
                                        + 0.5 * (1.0 - signMidCoordPos.y) * invNoonFactor; // consistency357381
                                    #endif

                                    sandNoiseIntensity = 0.8, mossNoiseIntensity = 0.0, isFoliage = true;

                                    #if EMISSIVE_FLOWERS > 0 || defined EMISSIVE_BLOOD_MOON_FLOWERS
                                        if (mat == 10003 && max(color.b, color.r * 1.3) > color.g) { // Flowers
                                            emission = 2.0 * skyLightCheck;
                                            #if EMISSIVE_FLOWERS == 2
                                                emission = max(emission, rainFactor + 1.0 * rainFactor);
                                            #endif
                                            #if EMISSIVE_FLOWERS > 0
                                                #if EMISSIVE_FLOWERS_TYPE == 1
                                                    if (color.b < max(color.r, color.g * 1.1) * 0.95) emission = 0.0;
                                                #elif EMISSIVE_FLOWERS_TYPE == 2
                                                    if (color.r < max(color.b * 1.15, color.g * 1.1) * 0.95) emission = 0.0;
                                                #endif
                                            #else
                                                emission *= int(color.r > max(color.b * 1.15, color.g * 2.5) * 0.95) * getBloodMoon(moonPhase, sunVisibility);
                                            #endif
                                            emission *= EMISSIVE_FLOWERS_STRENGTH;
                                        }
                                    #endif
                                }
                            } else {
                                if (mat < 10012) { // Leaves
                                    #include "/lib/materials/specificMaterials/terrain/leaves.glsl"

                                    #if EMISSIVE_FLOWERS > 0 && EMISSIVE_FLOWERS_TYPE < 2
                                        if (mat == 10011 && max(color.b, color.r * 0.7) > color.g) { // Flowering Azalea Leaves
                                            emission = skyLightCheck;

                                            #if EMISSIVE_FLOWERS == 2
                                                emission = max(emission, rainFactor + 1.0 * rainFactor);
                                            #endif
                                            emission *= EMISSIVE_FLOWERS_STRENGTH;
                                        }
                                    #endif
                                    #ifdef PINKER_CHERRY_LEAVES
                                        if (mat == 10007 && color.b > 0.5 && color.r > 0.85) {
                                            color.rgb *= vec3(1.0, 0.66, 0.87) + 0.2;
                                            color.rgb = clamp01(color.rgb);
                                        }
                                    #endif
                                }
                                else /*if (mat < 10014)*/ { // Vine
                                    subsurfaceMode = 3, centerShadowBias = true; noSmoothLighting = true;

                                    #if defined COATED_TEXTURES && defined GBUFFERS_TERRAIN
                                        doTileRandomisation = false;
                                    #endif

                                    float factor = color.g;
                                    smoothnessG = factor * 0.5;
                                    highlightMult = factor * 4.0 + 2.0;
                                    float fresnel = clamp(1.0 + dot(normalM, normalize(viewPos)), 0.0, 1.0);
                                    highlightMult *= 1.0 - pow2(pow2(fresnel));

                                    sandNoiseIntensity = 0.3, mossNoiseIntensity = 0.0, isFoliage = true;
                                }
                            }
                        } else {
                            if (mat < 10024) {
                                if (mat < 10020) { // Non-waving Foliage
                                    subsurfaceMode = 1, noSmoothLighting = true, noDirectionalShading = true;

                                    sandNoiseIntensity = 0.3, mossNoiseIntensity = 0.0, isFoliage = true;
                                    if (mat == 10019) {
                                        #if EMISSIVE_FLOWERS > 0 && EMISSIVE_FLOWERS_TYPE < 2
                                            if (max(color.b * 1.25, color.r * 0.91) > color.g) { // Flowers
                                                emission = 1.5 * skyLightCheck;

                                                #if EMISSIVE_FLOWERS == 2
                                                    emission = max(emission, rainFactor + 1.0 * rainFactor);
                                                #endif
                                                emission *= EMISSIVE_FLOWERS_STRENGTH;
                                            }
                                        #endif
                                        #ifdef PINKER_CHERRY_LEAVES
                                            if (color.b > 0.5 && color.r > 0.85) color.rgb *= vec3(1.0, 0.87, 0.97); // Pink Petals
                                        #endif
                                    }
                                }
                                else /*if (mat < 10024)*/ { // Upper Waving Foliage
                                    subsurfaceMode = 1, noSmoothLighting = true, noDirectionalShading = true;

                                    #ifdef GBUFFERS_TERRAIN
                                        DoFoliageColorTweaks(color.rgb, shadowMult, snowMinNdotU, viewPos, nViewPos, lViewPos, dither);

                                        #ifdef COATED_TEXTURES
                                            doTileRandomisation = false;
                                        #endif
                                    #endif

                                    #if SHADOW_QUALITY == -1
                                        shadowMult *= 1.0 + invNoonFactor; // consistency357381
                                    #endif

                                    sandNoiseIntensity = 0.8, mossNoiseIntensity = 0.0, isFoliage = true;

                                    #if EMISSIVE_FLOWERS > 0 || defined EMISSIVE_BLOOD_MOON_FLOWERS
                                        if (mat == 10023 && max(color.b, color.r * 1.3) > color.g) { // Large Flowers Upper Half
                                            #if EMISSIVE_FLOWERS > 0
                                                emission = 2.0 * skyLightCheck;
                                                #if EMISSIVE_FLOWERS == 2
                                                    emission = max(emission, rainFactor + 1.0 * rainFactor);
                                                #endif
                                                #if EMISSIVE_FLOWERS_TYPE == 1
                                                    if (color.b < max(color.r, color.g * 1.1) * 0.95) emission = 0.0;
                                                #elif EMISSIVE_FLOWERS_TYPE == 2
                                                    if (color.r < max(color.b * 1.15, color.g * 1.1) * 0.95) emission = 0.0;
                                                #endif
                                            #else
                                                emission *= int(color.r > max(color.b * 1.15, color.g * 2.5) * 0.95) * getBloodMoon(moonPhase, sunVisibility);
                                            #endif
                                            emission *= EMISSIVE_FLOWERS_STRENGTH;
                                        }
                                    #endif
                                }
                            } else { 
                                if (mat < 10025) { // Auto Modded Ores - Stone
                                    #ifdef GLOWING_ORE_MODDED
                                        #include "/lib/materials/specificMaterials/terrain/autoModdedOres.glsl"
                                        if (emission < 0.1) {
                                            #include "/lib/materials/specificMaterials/terrain/stone.glsl"
                                        }
                                        emission *= GLOWING_ORE_MULT;
                                        //color.rgb = avgBorderColor;

                                        #ifdef SITUATIONAL_ORES
                                            emission *= skyLightCheck;
                                        #endif
                                    #endif
                                } else if (mat < 10026) {  // Short Foliage / Foliage Lower Half - No Subsurface Scattering
                                    noSmoothLighting = true;

                                    #ifdef GBUFFERS_TERRAIN
                                        DoFoliageColorTweaks(color.rgb, shadowMult, snowMinNdotU, viewPos, nViewPos, lViewPos, dither);
                                    #endif

                                    #if SHADOW_QUALITY == -1
                                        shadowMult *= 1.0 - 0.3 * (signMidCoordPos.y + 1.0) * (1.0 - abs(signMidCoordPos.x))
                                        + 0.5 * (1.0 - signMidCoordPos.y) * invNoonFactor; // consistency357381
                                    #endif

                                    sandNoiseIntensity = 0.8, mossNoiseIntensity = 0.0, isFoliage = true;

                                } else if (mat < 10027) { // Auto Modded Ores - Netherrack
                                    #ifdef GLOWING_ORE_MODDED
                                        #include "/lib/materials/specificMaterials/terrain/autoModdedOres.glsl"
                                        if (emission < 0.1) {
                                            #include "/lib/materials/specificMaterials/terrain/netherrack.glsl"
                                        }
                                        emission *= GLOWING_ORE_MULT;
                                        //color.rgb = avgBorderColor;

                                        #ifdef SITUATIONAL_ORES
                                            emission *= skyLightCheck;
                                        #endif
                                    #endif
                                } else if (mat < 10028) { // Tall Foliage / Foliage Upper Half - No Subsurface Scattering
                                    noSmoothLighting = true;

                                    #ifdef GBUFFERS_TERRAIN
                                        DoFoliageColorTweaks(color.rgb, shadowMult, snowMinNdotU, viewPos, nViewPos, lViewPos, dither);
                                    #endif

                                    #if SHADOW_QUALITY == -1
                                        shadowMult *= 1.0 + invNoonFactor; // consistency357381
                                    #endif

                                    sandNoiseIntensity = 0.8, mossNoiseIntensity = 0.0, isFoliage = true;

                                } else if (mat < 10029) { // Auto Modded Ores - Endstone
                                    #ifdef GLOWING_ORE_MODDED
                                        #include "/lib/materials/specificMaterials/terrain/autoModdedOres.glsl"
                                        if (emission < 0.1) {
                                            #include "/lib/materials/specificMaterials/terrain/endStone.glsl"
                                        }
                                        emission *= GLOWING_ORE_MULT;
                                        //color.rgb = avgBorderColor;

                                        #ifdef SITUATIONAL_ORES
                                            emission *= skyLightCheck;
                                        #endif
                                    #endif
                                } else if (mat < 10030) { // Crimson Roots
                                    subsurfaceMode = 1, noSmoothLighting = true, noDirectionalShading = true;

                                    #ifdef GBUFFERS_TERRAIN
                                        DoFoliageColorTweaks(color.rgb, shadowMult, snowMinNdotU, viewPos, nViewPos, lViewPos, dither);
                                    #endif

                                    #if SHADOW_QUALITY == -1
                                        shadowMult *= 1.0 - 0.3 * (signMidCoordPos.y + 1.0) * (1.0 - abs(signMidCoordPos.x))
                                        + 0.5 * (1.0 - signMidCoordPos.y) * invNoonFactor; // consistency357381
                                    #endif

                                    #ifdef SOUL_SAND_VALLEY_OVERHAUL_INTERNAL
                                        color.rgb = mix(color.rgb, saturateColors(color.rgb * vec3(0.9, 0.7, 0.1), 0.85), inSoulValley); // Color curve to make it look better
                                    #endif

                                    sandNoiseIntensity = 0.8, mossNoiseIntensity = 0.0, isFoliage = true;
                                } else if (mat < 10032) { // Short foliage - no interactive foliage
                                    subsurfaceMode = 1, noSmoothLighting = true, noDirectionalShading = true;

                                    #ifdef GBUFFERS_TERRAIN
                                        DoFoliageColorTweaks(color.rgb, shadowMult, snowMinNdotU, viewPos, nViewPos, lViewPos, dither);

                                        #ifdef COATED_TEXTURES
                                            doTileRandomisation = false;
                                        #endif
                                    #endif

                                    #if SHADOW_QUALITY == -1
                                        shadowMult *= 1.0 - 0.3 * (signMidCoordPos.y + 1.0) * (1.0 - abs(signMidCoordPos.x))
                                        + 0.5 * (1.0 - signMidCoordPos.y) * invNoonFactor; // consistency357381
                                    #endif

                                    sandNoiseIntensity = 0.8, mossNoiseIntensity = 0.0, isFoliage = true;
                                }
                            }
                        }
                    } else {
                        if (mat < 10048) {
                            if (mat < 10040) {
                                if (mat < 10035) { // Stone Bricks++
                                    #include "/lib/materials/specificMaterials/terrain/stone.glsl"

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.66;
                                    #endif
                                }
                                else if (mat < 10036){ // Sugar Cane
                                    subsurfaceMode = 1, noSmoothLighting = true, noDirectionalShading = true;

                                    sandNoiseIntensity = 0.3, mossNoiseIntensity = 0.0, isFoliage = true;
                                }
                                else /*if (mat < 10040)*/ { // Anvil+
                                    #include "/lib/materials/specificMaterials/terrain/anvil.glsl"
                                }
                            } else {
                                if (mat < 10044) { // Rails
                                    #if ANISOTROPIC_FILTER == 0
                                        color = texture2DLod(tex, texCoord, 0);
                                    #endif

                                    noSmoothLighting = true;
                                    if (color.r > 0.1 && color.g + color.b < 0.1) { // Redstone Parts
                                        noSmoothLighting = true; noDirectionalShading = true;
                                        lmCoordM.x = min(lmCoordM.x * 0.9, 0.77);

                                        if (color.r > 0.5) {
                                            color.rgb *= color.rgb;
                                            emission = 8.0 * color.r;

                                            overlayNoiseIntensity = 0.35, overlayNoiseEmission = 0.2;
                                        } else if (color.r > color.g * 2.0) {
                                            materialMask = OSIEBCA * 5.0; // Redstone Fresnel

                                            float factor = pow2(color.r);
                                            smoothnessG = 0.4;
                                            highlightMult = factor + 0.4;

                                            smoothnessD = factor * 0.7 + 0.3;
                                        }
                                    } else if (abs(color.r - color.b) < 0.15) { // Iron Parts
                                        #include "/lib/materials/specificMaterials/terrain/ironBlock.glsl"
                                    } else if (color.g > color.b * 2.0) { // Gold Parts
                                        #include "/lib/materials/specificMaterials/terrain/goldBlock.glsl"
                                    } else { // Wood Parts
                                        #include "/lib/materials/specificMaterials/planks/oakPlanks.glsl"
                                    }
                                }
                                else /*if (mat < 10048)*/ { // Empty Cauldron, Hopper
                                    noSmoothLighting = true;
                                    lmCoordM.x = min(lmCoordM.x, 0.9333);

                                    #include "/lib/materials/specificMaterials/terrain/anvil.glsl"

                                    if (mat == 10047) { // Disabled Hopper
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                            }
                        } else {
                            if (mat < 10056) {
                                if (mat < 10052) { // Water Cauldron
                                    noSmoothLighting = true;
                                    lmCoordM.x = min(lmCoordM.x, 0.9333);

                                    vec3 worldPos = playerPos + cameraPosition;
                                    vec3 fractPos = fract(worldPos.xyz);
                                    vec2 coordM = abs(fractPos.xz - 0.5);
                                    if (max(coordM.x, coordM.y) < 0.375 && fractPos.y > 0.3 && NdotU > 0.9) {
                                        #ifdef SHADER_WATER
                                            #if WATER_STYLE < 3 || PIXEL_WATER == 1
                                                vec3 colorP = color.rgb / glColor.rgb;
                                                smoothnessG = min(pow2(pow2(dot(colorP.rgb, colorP.rgb) * 0.4)), 1.0);
                                                highlightMult = 3.25;
                                                smoothnessD = 0.8;
                                            #else
                                                smoothnessG = 0.3;
                                                smoothnessD = 1.0;
                                            #endif

                                            #include "/lib/materials/specificMaterials/translucents/water.glsl"

                                            #ifdef COATED_TEXTURES
                                                noiseFactor = 0.0;
                                            #endif
                                        #endif

                                        overlayNoiseIntensity = 0.0;
                                    } else {
                                        #include "/lib/materials/specificMaterials/terrain/anvil.glsl"
                                    }
                                }
                                else /*if (mat < 10056)*/ { // Powder Snow Cauldron
                                    noSmoothLighting = true;
                                    lmCoordM.x = min(lmCoordM.x, 0.9333);

                                    vec3 worldPos = playerPos + cameraPosition;
                                    vec3 fractPos = fract(worldPos.xyz);
                                    vec2 coordM = abs(fractPos.xz - 0.5);
                                    if (max(coordM.x, coordM.y) < 0.375 &&
                                        fractPos.y > 0.3 &&
                                        NdotU > 0.9) {

                                        #include "/lib/materials/specificMaterials/terrain/snow.glsl"

                                        overlayNoiseIntensity = 0.4;
                                    } else {
                                        #include "/lib/materials/specificMaterials/terrain/anvil.glsl"
                                    }
                                }
                            } else {
                                if (mat < 10060) { // Lava Cauldron
                                    noSmoothLighting = true;
                                    lmCoordM.x = min(lmCoordM.x, 0.9333);

                                    vec3 worldPos = playerPos + cameraPosition;
                                    vec3 fractPos = fract(worldPos.xyz);
                                    vec2 coordM = abs(fractPos.xz - 0.5);
                                    if (max(coordM.x, coordM.y) < 0.375 &&
                                        fractPos.y > 0.3 &&
                                        NdotU > 0.9) {

                                        #include "/lib/materials/specificMaterials/terrain/lava.glsl"

                                        sandNoiseIntensity = 0.0, mossNoiseIntensity = 0.0;
                                    } else {
                                        #include "/lib/materials/specificMaterials/terrain/anvil.glsl"
                                    }
                                }
                                else /*if (mat < 10061)*/ { // Lever
                                    if (color.r > color.g + color.b) {
                                        color.rgb *= color.rgb;
                                        emission = 4.0;

                                        overlayNoiseIntensity = 0.1, overlayNoiseEmission = 0.3;
                                    } else {
                                        #include "/lib/materials/specificMaterials/terrain/cobblestone.glsl"
                                    }
                                }
                            }
                        }
                    }
                } else {
                    if (mat < 10096) {
                        if (mat < 10080) {
                            if (mat < 10072) {
                                if (mat < 10068) { // Lectern
                                    #include "/lib/materials/specificMaterials/planks/oakPlanks.glsl"
                                }
                                else /*if (mat < 10072)*/ { // Lava
                                    #include "/lib/materials/specificMaterials/terrain/lava.glsl"

                                    #if defined COATED_TEXTURES && defined GBUFFERS_TERRAIN
                                        doTileRandomisation = false;
                                    #endif

                                    #ifdef DISTANT_LIGHT_BOKEH
                                        DoDistantLightBokehMaterial(emission, 4.5, lViewPos);
                                    #endif

                                    sandNoiseIntensity = 0.0, mossNoiseIntensity = 0.0;
                                }
                            } else {
                                if (mat < 10076) { // Fire
                                    noSmoothLighting = true, noDirectionalShading = true;
                                    emission = 2.35;
                                    color.rgb *= sqrt1(GetLuminance(color.rgb));

                                    overlayNoiseIntensity = 0.0;

                                    #if (defined SOUL_SAND_VALLEY_OVERHAUL_INTERNAL || defined PURPLE_END_FIRE_INTERNAL) && defined GBUFFERS_TERRAIN
                                        float uniformValue = 1.0;
                                        vec3 colorFire = vec3(0.0);
                                        #ifdef NETHER
                                            uniformValue = inSoulValley;
                                            colorFire = colorSoul;
                                            float gradient = mix(1.0, 0.0, clamp01(blockUV.y + 3.0 * blockUV.y));
                                        #endif
                                        #ifdef END
                                            uniformValue = 1.0;
                                            colorFire = colorEndBreath * 1.5;
                                            float gradient = mix(1.0, 0.0, clamp01(blockUV.y + 0.15 - 1.1 * clamp01(sin(texture2D(noisetex, vec2(frameTimeCounter * 0.01)).r) * blockUV.y)));
                                        #endif
                                        color.rgb = mix(color.rgb, mix(color.rgb, vec3(GetLuminance(color.rgb)), 0.88), uniformValue * gradient);
                                        color.rgb *= mix(vec3(1.0), colorFire * 2.0, uniformValue * gradient);
                                    #endif
                                }
                                else /*if (mat < 10080)*/ { // Soul Fire
                                    noSmoothLighting = true, noDirectionalShading = true;
                                    emission = 1.5;
                                    color.rgb = pow1_5(color.rgb);

                                    overlayNoiseIntensity = 0.0;
                                }
                            }
                        } else {
                            if (mat < 10088) {
                                if (mat < 10084) { // Stone+, Coal Ore, Smooth Stone+, Grindstone, Stonecutter
                                    #include "/lib/materials/specificMaterials/terrain/stone.glsl"

                                    if (mat == 10083) { // Powered Stone Pressure Plate and Stone Button
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                                else /*if (mat < 10088)*/ { // Granite+
                                    smoothnessG = pow2(pow2(color.r)) * 0.75;
                                    smoothnessD = smoothnessG;
                                }
                            } else {
                                if (mat < 10092) { // Diorite+
                                    smoothnessG = pow2(pow2(color.g)) * 0.5;
                                    smoothnessD = smoothnessG;

                                    #ifdef GBUFFERS_TERRAIN
                                        DoBrightBlockTweaks(color.rgb, 0.75, shadowMult, highlightMult);
                                    #endif
                                }
                                else /*if (mat < 10096)*/ { // Andesite+
                                    smoothnessG = pow2(pow2(color.g)) * 1.3;
                                    smoothnessG = min1(smoothnessG);
                                    smoothnessD = smoothnessG;
                                }
                            }
                        }
                    } else {
                        if (mat < 10112) {
                            if (mat < 10104) {
                                if (mat < 10100) { // Polished Granite+
                                    smoothnessG = 0.1 + color.r * 0.4;
                                    smoothnessD = smoothnessG;

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.77;
                                    #endif
                                }
                                else /*if (mat < 10104)*/ { // Polished Diorite+
                                    smoothnessG = pow2(color.g) * 0.7;
                                    smoothnessD = smoothnessG;

                                    #ifdef GBUFFERS_TERRAIN
                                        DoBrightBlockTweaks(color.rgb, 0.75, shadowMult, highlightMult);
                                    #endif

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.77;
                                    #endif
                                }
                            } else {
                                if (mat < 10108) { // Polished Andesite+, Packed Mud, Mud Bricks+, Bricks+
                                    smoothnessG = pow2(color.g);
                                    smoothnessD = smoothnessG;

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.77;
                                    #endif
                                }
                                else /*if (mat < 10112)*/ { // Deepslate:Non-polished Variants, Deepslate Coal Ore
                                    #include "/lib/materials/specificMaterials/terrain/deepslate.glsl"
                                }
                            }
                        } else {
                            if (mat < 10120) {
                                if (mat < 10116) { // Deepslate:Polished Variants, Mud, Mangrove Roots, Muddy Mangrove Roots
                                    #include "/lib/materials/specificMaterials/terrain/deepslate.glsl"

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.77;
                                    #endif
                                }
                                else /*if (mat < 10120)*/ { // Calcite
                                    highlightMult = pow2(color.g) + 1.0;
                                    smoothnessG = 1.0 - color.g * 0.5;
                                    smoothnessD = smoothnessG;

                                    #ifdef GBUFFERS_TERRAIN
                                        DoBrightBlockTweaks(color.rgb, 0.75, shadowMult, highlightMult);
                                    #endif
                                }
                            } else {
                                if (mat < 10124) { // Dripstone+, Daylight Detector
                                    smoothnessG = color.r * 0.35 + 0.2;
                                    smoothnessD = smoothnessG;

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.66;
                                    #endif

                                    #ifdef REDSTONE_IPBR
                                        if (mat == 10123) { // Daylight Detector
                                            if (color.r > 0.5 && color.g > 0.5 && color.b > 0.5) smoothnessD = 1.0;
                                            redstoneIPBR(color.rgb, emission);
                                        }
                                    #endif
                                }
                                else /*if (mat < 10128)*/ { // Snowy Variants of Grass Block, Podzol, Mycelium
                                    float dotColor = dot(color.rgb, color.rgb);
                                    if (dotColor > 1.5) { // Snowy Variants:Snowy Part
                                        #include "/lib/materials/specificMaterials/terrain/snow.glsl"

                                        overlayNoiseIntensity = 0.0;
                                    } else { // Snowy Variants:Dirt Part
                                        #include "/lib/materials/specificMaterials/terrain/dirt.glsl"
                                    }
                                }
                            }
                        }
                    }
                }
            } else {
                if (mat < 10192) {
                    if (mat < 10160) {
                        if (mat < 10144) {
                            if (mat < 10136) {
                                if (mat < 10132) { // Dirt, Coarse Dirt, Rooted Dirt, Podzol:Normal, Mycelium:Normal, Farmland:Dry
                                    #include "/lib/materials/specificMaterials/terrain/dirt.glsl"
                                }
                                else /*if (mat < 10136)*/ { // Grass Block:Normal
                                    if (glColor.b < 0.999) { // Grass Block:Normal:Grass Part
                                        smoothnessG = pow2(color.g);

                                        #ifdef SNOWY_WORLD
                                            snowMinNdotU = min(pow2(pow2(color.g)) * 1.9, 0.1);
                                            color.rgb = color.rgb * 0.5 + 0.5 * (color.rgb / glColor.rgb);
                                        #endif
                                    } else { //Grass Block:Normal:Dirt Part
                                        #include "/lib/materials/specificMaterials/terrain/dirt.glsl"
                                    }
                                }
                            } else {
                                if (mat < 10140) { // Farmland:Wet
                                    if (NdotU > 0.99) { // Farmland:Wet:Top Part
                                        #if MC_VERSION >= 11300
                                            smoothnessG = clamp(pow2(pow2(1.0 - color.r)) * 2.5, 0.5, 1.0);
                                            highlightMult = 0.5 + smoothnessG * smoothnessG * 2.0;
                                            smoothnessD = smoothnessG * 0.75;
                                        #else
                                            smoothnessG = 0.5 * (1.0 + abs(color.r - color.b) + color.b);
                                            smoothnessD = smoothnessG * 0.5;
                                        #endif
                                    } else { // Farmland:Wet:Dirt Part
                                        #include "/lib/materials/specificMaterials/terrain/dirt.glsl"
                                    }
                                }
                                else /*if (mat < 10144)*/ { // Netherrack
                                    #include "/lib/materials/specificMaterials/terrain/netherrack.glsl"
                                }
                            }
                        } else {
                            if (mat < 10151) { // MV: Piston, Dispenser, Dropper
                                if (mat < 10148) { // Warped Nylium, Warped Wart Block
                                    if (color.g == color.b && color.g > 0.0001) { // Warped Nylium:Netherrack Part
                                        #include "/lib/materials/specificMaterials/terrain/netherrack.glsl"
                                    } else { // Warped Nylium:Nylium Part, Warped Wart Block
                                        smoothnessG = color.g * 0.5;
                                        smoothnessD = smoothnessG;

                                        #ifdef COATED_TEXTURES
                                            noiseFactor = 0.77;
                                        #endif

                                        #ifdef GLOWING_WART
                                            if (mat == 10146 && color.g > 0.7) { // Warped Wart Block
                                                overlayNoiseIntensity = 0.7, overlayNoiseEmission = 0.8;
                                                emission = 2.4;
                                                #ifdef GBUFFERS_TERRAIN
                                                    vec2 bpos = floor(playerPos.xz + cameraPosition.xz + 0.5)
                                                              + floor(playerPos.y + cameraPosition.y + 0.5);
                                                    bpos = bpos * 0.01 + 0.005 * frameTimeCounter;
                                                    emission *= pow2(texture2D(noisetex, bpos).r * pow1_5(texture2D(noisetex, bpos * 0.5).r));
                                                    emission *= 4.0;
                                                #endif
                                            }
                                        #endif
                                    }
                                }
                                else /*if (mat < 10152)*/ { // Crimson Nylium, Nether Wart Block
                                    if (color.g == color.b && color.g > 0.0001 && color.r < 0.522) { // Crimson Nylium:Netherrack Part
                                        #include "/lib/materials/specificMaterials/terrain/netherrack.glsl"
                                    } else { // Crimson Nylium:Nylium Part, Nether Wart Block
                                        smoothnessG = color.r * 0.5;
                                        smoothnessD = smoothnessG;

                                        #ifdef SOUL_SAND_VALLEY_OVERHAUL_INTERNAL
                                            if (mat == 10148) color.rgb = mix(color.rgb, saturateColors(color.rgb * vec3(1.2, 0.7, 0.8) * 0.7, 0.8), inSoulValley); // Color curve to make it look better
                                        #endif

                                        #ifdef COATED_TEXTURES
                                            noiseFactor = 0.77;
                                        #endif

                                        #ifdef GLOWING_WART
                                            if (mat == 10150 && color.r > 0.6) { // Nether Wart Block
                                                overlayNoiseEmission = 0.28;
                                                emission = 16.0 * color.g;
                                                #ifdef GBUFFERS_TERRAIN
                                                    vec2 bpos = floor(playerPos.xz + cameraPosition.xz + 0.5)
                                                              + floor(playerPos.y + cameraPosition.y + 0.5);
                                                    bpos = bpos * 0.01 + 0.005 * frameTimeCounter;
                                                    emission *= pow2(texture2D(noisetex, bpos).r * pow1_5(texture2D(noisetex, bpos * 0.5).r));
                                                    emission *= 4.0;
                                                #endif
                                            }
                                        #endif
                                    }
                                }
                            } else {
                                if (mat < 10156) { // Cobblestone+, Mossy Cobblestone+, Furnace:Unlit, Smoker:Unlit, Blast Furnace:Unlit, Moss Block+, Lodestone, Piston, Sticky Piston, Dispenser, Dropper
                                    #include "/lib/materials/specificMaterials/terrain/cobblestone.glsl"

                                    if (mat == 10151) { // Extended Piston and Sticky Piston and Powered Dispenser and Dropper
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                    else if (mat == 10154 || mat == 10155) { // Moss Block+
                                        mossNoiseIntensity = 0.0;
                                    }
                                }
                                else /*if (mat < 10160)*/ { // Oak Planks++:Clean Variants, Bookshelf, Crafting Table, Tripwire Hook
                                    #include "/lib/materials/specificMaterials/planks/oakPlanks.glsl"

                                    if (mat == 10159) { // Powered Oak Button, Pressure Plate, Fence Gate and Tripwire Hook
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                            }
                        }
                    } else {
                        if (mat < 10176) {
                            if (mat < 10168) {
                                if (mat < 10164) { // Oak Log, Oak Wood
                                    if (color.g > 0.48 ||
                                        CheckForColor(color.rgb, vec3(126, 98, 55)) ||
                                        CheckForColor(color.rgb, vec3(150, 116, 65))) { // Oak Log:Clean Part
                                        #include "/lib/materials/specificMaterials/planks/oakPlanks.glsl"
                                    } else { // Oak Log:Wood Part, Oak Wood
                                        #include "/lib/materials/specificMaterials/terrain/oakWood.glsl"
                                    }
                                }
                                else /*if (mat < 10168)*/ { // Spruce Planks++:Clean Variants
                                    #include "/lib/materials/specificMaterials/planks/sprucePlanks.glsl"

                                    if (mat == 10167) { // Powered Spruce Redstone Components
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                            } else {
                                if (mat < 10172) { // Spruce Log, Spruce Wood
                                    if (color.g > 0.25) { // Spruce Log:Clean Part
                                        #include "/lib/materials/specificMaterials/planks/sprucePlanks.glsl"
                                    } else { // Spruce Log:Wood Part, Spruce Wood
                                        smoothnessG = pow2(color.g) * 2.5;
                                        smoothnessG = min1(smoothnessG);
                                        smoothnessD = smoothnessG;
                                    }
                                }
                                else /*if (mat < 10176)*/ { // Birch Planks++:Clean Variants, Scaffolding, Loom
                                    #include "/lib/materials/specificMaterials/planks/birchPlanks.glsl"

                                    if (mat == 10175) { // Powered Birch Redstone Components
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                            }
                        } else {
                            if (mat < 10184) {
                                if (mat < 10180) { // Birch Log, Birch Wood
                                    if (color.r - color.b > 0.15) { // Birch Log:Clean Part
                                        #include "/lib/materials/specificMaterials/planks/birchPlanks.glsl"
                                    } else { // Birch Log:Wood Part, Birch Wood
                                        smoothnessG = pow2(color.g) * 0.25;
                                        smoothnessD = smoothnessG;

                                        #ifdef COATED_TEXTURES
                                            noiseFactor = 1.25;
                                        #endif
                                    }
                                }
                                else /*if (mat < 10184)*/ { // Jungle Planks++:Clean Variants, Composter
                                    #include "/lib/materials/specificMaterials/planks/junglePlanks.glsl"

                                    if (mat == 10183) { // Powered Jungle Redstone Components
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                            } else {
                                if (mat < 10188) { // Jungle Log, Jungle Wood
                                    if (color.g > 0.405) { // Jungle Log:Clean Part
                                        #include "/lib/materials/specificMaterials/planks/junglePlanks.glsl"
                                    } else { // Jungle Log:Wood Part, Jungle Wood
                                        smoothnessG = pow2(pow2(color.g)) * 5.0;
                                        smoothnessG = min1(smoothnessG);
                                        smoothnessD = smoothnessG;

                                        #ifdef COATED_TEXTURES
                                            noiseFactor = 0.77;
                                        #endif
                                    }
                                }
                                else /*if (mat < 10192)*/ { // Acacia Planks++:Clean Variants
                                    #include "/lib/materials/specificMaterials/planks/acaciaPlanks.glsl"

                                    if (mat == 10191) { // Powered Acacia Redstone Components
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                            }
                        }
                    }
                } else {
                    if (mat < 10224) {
                        if (mat < 10208) {
                            if (mat < 10200) {
                                if (mat < 10196) { // Acacia Log, Acacia Wood
                                    if (color.r - color.b > 0.2) { // Acacia Log:Clean Part
                                        #include "/lib/materials/specificMaterials/planks/acaciaPlanks.glsl"
                                    } else { // Acacia Log:Wood Part, Acacia Wood
                                        smoothnessG = pow2(color.b) * 1.3;
                                        smoothnessG = min1(smoothnessG);
                                        smoothnessD = smoothnessG;

                                        #ifdef COATED_TEXTURES
                                            noiseFactor = 0.66;
                                        #endif
                                    }
                                }
                                else /*if (mat < 10200)*/ { // Dark Oak Planks++:Clean Variants
                                    #include "/lib/materials/specificMaterials/planks/darkOakPlanks.glsl"

                                    if (mat == 10199) { // Powered Dark Oak Redstone Components
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                            } else {
                                if (mat < 10204) { // Dark Oak Log, Dark Oak Wood
                                    if (color.r - color.g > 0.08 ||
                                        CheckForColor(color.rgb, vec3(48, 30, 14))) { // Dark Oak Log:Clean Part
                                        #include "/lib/materials/specificMaterials/planks/darkOakPlanks.glsl"
                                    } else { // Dark Oak Log:Wood Part, Dark Oak Wood
                                        smoothnessG = color.r * 0.4;
                                        smoothnessD = smoothnessG;
                                    }
                                }
                                else /*if (mat < 10208)*/ { // Mangrove Planks++:Clean Variants
                                    #include "/lib/materials/specificMaterials/planks/mangrovePlanks.glsl"

                                    if (mat == 10207) { // Powered Mangrove Redstone Components
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                            }
                        } else {
                            if (mat < 10216) {
                                if (mat < 10212) { // Mangrove Log, Mangrove Wood
                                    if (color.r - color.g > 0.2) { // Mangrove Log:Clean Part
                                        #include "/lib/materials/specificMaterials/planks/mangrovePlanks.glsl"
                                    } else { // Mangrove Log:Wood Part, Mangrove Wood
                                        smoothnessG = pow2(color.r) * 0.6;
                                        smoothnessD = smoothnessG;
                                    }
                                }
                                else /*if (mat < 10216)*/ { // Crimson Planks++:Clean Variants
                                    #include "/lib/materials/specificMaterials/planks/crimsonPlanks.glsl"

                                    if (mat == 10215) { // Powered Crimson Redstone Components
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                            } else {
                                if (mat < 10220) { // Crimson Stem, Crimson Hyphae
                                    if (color.r / color.b <= 2.5) { // Flat Part
                                        #include "/lib/materials/specificMaterials/planks/crimsonPlanks.glsl"

                                    #ifdef GLOWING_NETHER_TREES
                                    } else { // Emissive Part
                                        emission = pow2(color.r) * 6.5;
                                        color.gb *= 0.5;
                                        overlayNoiseIntensity = 0.6, overlayNoiseEmission = 0.15;
                                    #endif
                                    }
                                }
                                else /*if (mat < 10224)*/ { // Warped Planks++:Clean Variants
                                    #include "/lib/materials/specificMaterials/planks/warpedPlanks.glsl"

                                    if (mat == 10223) { // Powered Warped Redstone Components
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                            }
                        }
                    } else {
                        if (mat < 10240) {
                            if (mat < 10232) {
                                if (mat < 10228) { // Warped Stem, Warped Hyphae
                                    //if (color.r < 0.12 || color.r + color.g * 3.0 < 3.4 * color.b) { // Emissive Part
                                    if (color.r >= 0.37 * color.b && color.r + color.g * 3.0 >= 3.4 * color.b) { // Flat Part
                                        #include "/lib/materials/specificMaterials/planks/warpedPlanks.glsl"

                                    #ifdef GLOWING_NETHER_TREES
                                    } else { // Emissive Part
                                        emission = pow2(color.g + 0.2 * color.b) * 4.5 + 0.15;
                                        overlayNoiseIntensity = 0.7, overlayNoiseEmission = 0.3;
                                    #endif
                                    }
                                }
                                else /*if (mat < 10232)*/ { // Bedrock
                                    smoothnessG = color.b * 0.2 + 0.1;
                                    smoothnessD = smoothnessG;

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 1.5;
                                    #endif
                                }
                            } else {
                                if (mat < 10236) { // Sand, Suspicious Sand
                                    smoothnessG = pow(color.g, 16.0) * 2.0;
                                    smoothnessG = min1(smoothnessG);
                                    smoothnessD = smoothnessG;
                                    highlightMult = 2.0;

                                    #ifdef GBUFFERS_TERRAIN
                                        DoBrightBlockTweaks(color.rgb, 0.5, shadowMult, highlightMult);

                                        DoOceanBlockTweaks(smoothnessD);
                                    #endif

                                    #if RAIN_PUDDLES >= 1 || defined SPOOKY_RAIN_PUDDLE_OVERRIDE
                                        noPuddles = 1.0;
                                    #endif
                                }
                                else /*if (mat < 10240)*/ { // Red Sand
                                    smoothnessG = pow(color.r * 1.08, 16.0) * 2.0;
                                    smoothnessG = min1(smoothnessG);
                                    smoothnessD = smoothnessG;
                                    highlightMult = 2.0;

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.77;
                                    #endif

                                    #if RAIN_PUDDLES >= 1 || defined SPOOKY_RAIN_PUDDLE_OVERRIDE
                                        noPuddles = 1.0;
                                    #endif
                                }
                            }
                        } else {
                            if (mat < 10248) {
                                if (mat < 10244) { // Sandstone+
                                    highlightMult = 2.0;
                                    smoothnessG = pow2(pow2(color.g)) * 0.5;
                                    smoothnessG = min1(smoothnessG);
                                    smoothnessD = smoothnessG;

                                    #ifdef GBUFFERS_TERRAIN
                                        DoBrightBlockTweaks(color.rgb, 0.5, shadowMult, highlightMult);
                                    #endif

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.77;
                                    #endif
                                }
                                else /*if (mat < 10248)*/ { // Red Sandstone+
                                    highlightMult = 2.0;
                                    smoothnessG = pow2(pow2(color.r * 1.08)) * 0.5;
                                    smoothnessG = min1(smoothnessG);
                                    smoothnessD = smoothnessG;

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.5;
                                    #endif
                                }
                            } else {
                                if (mat < 10252) { // Netherite Block
                                    #include "/lib/materials/specificMaterials/terrain/netheriteBlock.glsl"
                                }
                                else /*if (mat < 10256)*/ { // Ancient Debris
                                    smoothnessG = pow2(color.r);
                                    smoothnessG = min1(smoothnessG);
                                    smoothnessD = smoothnessG;

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 1.5;
                                    #endif

                                    #ifdef GLOWING_ORE_ANCIENTDEBRIS
                                        emission = min(pow2(color.g * 6.0), 8.0);
                                        overlayNoiseIntensity = 0.2, overlayNoiseEmission = 0.8;
                                        #ifdef SITUATIONAL_ORES
                                            emission *= skyLightCheck;
                                            color.rgb = mix(color.rgb, color.rgb * pow(color.rgb, vec3(min1(GLOWING_ORE_MULT))), skyLightCheck);
                                        #else
                                            color.rgb *= pow(color.rgb, vec3(min1(GLOWING_ORE_MULT)));
                                        #endif
                                        emission *= GLOWING_ORE_MULT;
                                    #endif
                                }
                            }
                        }
                    }
                }
            }
        } else {
            if (mat < 10384) {
                if (mat < 10320) {
                    if (mat < 10288) {
                        if (mat < 10272) {
                            if (mat < 10264) {
                                if (mat < 10260) { // Iron Bars
                                    noSmoothLighting = true;
                                    #include "/lib/materials/specificMaterials/terrain/ironBlock.glsl"
                                }
                                else /*if (mat < 10264)*/ { // ACL solid blocks with no properties
                                    
                                }
                            } else {
                                if (mat < 10268) { // Iron Block, Heavy Weighted Pressure Plate
                                    #include "/lib/materials/specificMaterials/terrain/ironBlock.glsl"
                                    color.rgb *= max(color.r, 0.85) * 0.9;

                                    // color.rgb = vec3(0);
                                    // smoothnessD = 1.0;
                                    // smoothnessG = smoothnessD;
                                    // noGeneratedNormals = true;
                                    // overlayNoiseIntensity = 0.0;

                                    if (mat == 10267) { // Powered Heavy Weighted Pressure Plate
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                                else /*if (mat < 10272)*/ { // Raw Iron Block
                                    #include "/lib/materials/specificMaterials/terrain/rawIronBlock.glsl"
                                    #ifdef GLOWING_RAW_BLOCKS
                                        emission = pow1_5(color.r) * 1.5;

                                        overlayNoiseIntensity = 0.6, overlayNoiseEmission = 0.5;
                                        #ifdef SITUATIONAL_ORES
                                            emission *= skyLightCheck;
                                            color.rgb = mix(color.rgb, color.rgb * pow(color.rgb, vec3(0.5 * min1(GLOWING_ORE_MULT))), skyLightCheck);
                                        #else
                                            color.rgb *= pow(color.rgb, vec3(0.5 * min1(GLOWING_ORE_MULT)));
                                        #endif
                                        emission *= GLOWING_ORE_MULT;
                                    #endif
                                }
                            }
                        } else {
                            if (mat < 10280) {
                                if (mat < 10276) { // Iron Ore
                                    if (color.r != color.g) { // Iron Ore:Raw Iron Part
                                        #include "/lib/materials/specificMaterials/terrain/rawIronBlock.glsl"
                                        #ifdef GLOWING_ORE_IRON
                                            if (color.r - color.b > 0.15) {
                                                emission = pow1_5(color.r) * 1.5;

                                                overlayNoiseIntensity = 0.6, overlayNoiseEmission = 0.5;
                                                #ifdef SITUATIONAL_ORES
                                                    emission *= skyLightCheck;
                                                    color.rgb = mix(color.rgb, color.rgb * pow(color.rgb, vec3(0.5 * min1(GLOWING_ORE_MULT))), skyLightCheck);
                                                #else
                                                    color.rgb *= pow(color.rgb, vec3(0.5 * min1(GLOWING_ORE_MULT)));
                                                #endif
                                                emission *= GLOWING_ORE_MULT;
                                            }
                                        #endif
                                    } else { // Iron Ore:Stone Part
                                        #include "/lib/materials/specificMaterials/terrain/stone.glsl"
                                    }
                                }
                                else /*if (mat < 10280)*/ { // Deepslate Iron Ore
                                    if (color.r != color.g) { // Deepslate Iron Ore:Raw Iron Part
                                        #include "/lib/materials/specificMaterials/terrain/rawIronBlock.glsl"
                                        #ifdef GLOWING_ORE_IRON
                                            if (color.r - color.b > 0.15) {
                                                emission = pow1_5(color.r) * 1.5;

                                                overlayNoiseIntensity = 0.6, overlayNoiseEmission = 0.5;
                                                #ifdef SITUATIONAL_ORES
                                                    emission *= skyLightCheck;
                                                    color.rgb = mix(color.rgb, color.rgb * pow(color.rgb, vec3(0.5 * min1(GLOWING_ORE_MULT))), skyLightCheck);
                                                #else
                                                    color.rgb *= pow(color.rgb, vec3(0.5 * min1(GLOWING_ORE_MULT)));
                                                #endif
                                                emission *= GLOWING_ORE_MULT;
                                            }
                                        #endif
                                    } else { // Deepslate Iron Ore:Deepslate Part
                                        #include "/lib/materials/specificMaterials/terrain/deepslate.glsl"
                                    }
                                }
                            } else {
                                if (mat < 10284) { // Raw Copper Block
                                    #include "/lib/materials/specificMaterials/terrain/rawCopperBlock.glsl"
                                    #ifdef GLOWING_RAW_BLOCKS
                                        emission = pow2(color.r) * 1.5 + color.g * 1.3 + 0.2;

                                        overlayNoiseIntensity = 0.6, overlayNoiseEmission = 0.5;
                                        #ifdef SITUATIONAL_ORES
                                            emission *= skyLightCheck;
                                            color.rgb = mix(color.rgb, color.rgb * pow(color.rgb, vec3(min1(GLOWING_ORE_MULT))), skyLightCheck);
                                        #else
                                            color.rgb *= pow(color.rgb, vec3(min1(GLOWING_ORE_MULT)));
                                        #endif
                                        emission *= GLOWING_ORE_MULT;
                                    #endif
                                }
                                else /*if (mat < 10288)*/ { // Copper Ore
                                    if (color.r != color.g) { // Copper Ore:Raw Copper Part
                                        #include "/lib/materials/specificMaterials/terrain/rawCopperBlock.glsl"
                                        #ifdef GLOWING_ORE_COPPER
                                            if (max(color.r * 0.5, color.g) - color.b > 0.05) {
                                                emission = color.r * 2.0 + 0.7;

                                                overlayNoiseIntensity = 0.6, overlayNoiseEmission = 0.5;
                                                #ifdef SITUATIONAL_ORES
                                                    emission *= skyLightCheck;
                                                    color.rgb = mix(color.rgb, color.rgb * pow(color.rgb, vec3(min1(GLOWING_ORE_MULT))), skyLightCheck);
                                                #else
                                                    color.rgb *= pow(color.rgb, vec3(min1(GLOWING_ORE_MULT)));
                                                #endif
                                                emission *= GLOWING_ORE_MULT;
                                            }
                                        #endif
                                    } else { // Copper Ore:Stone Part
                                        #include "/lib/materials/specificMaterials/terrain/stone.glsl"
                                    }
                                }
                            }
                        }
                    } else {
                        if (mat < 10304) {
                            if (mat < 10296) {
                                if (mat < 10292) { // Deepslate Copper Ore
                                    if (color.r != color.g) { // Deepslate Copper Ore:Raw Copper Part
                                        #include "/lib/materials/specificMaterials/terrain/rawCopperBlock.glsl"
                                        #ifdef GLOWING_ORE_COPPER
                                            if (max(color.r * 0.5, color.g) - color.b > 0.05) {
                                                emission = color.r * 2.0 + 0.7;

                                                overlayNoiseIntensity = 0.6, overlayNoiseEmission = 0.5;
                                                #ifdef SITUATIONAL_ORES
                                                    emission *= skyLightCheck;
                                                    color.rgb = mix(color.rgb, color.rgb * pow(color.rgb, vec3(min1(GLOWING_ORE_MULT))), skyLightCheck);
                                                #else
                                                    color.rgb *= pow(color.rgb, vec3(min1(GLOWING_ORE_MULT)));
                                                #endif
                                                emission *= GLOWING_ORE_MULT;
                                            }
                                        #endif
                                    } else { // Deepslate Copper Ore:Deepslate Part
                                        #include "/lib/materials/specificMaterials/terrain/deepslate.glsl"
                                    }
                                }
                                else /*if (mat < 10296)*/ { // Copper Block++:All Non-raw Variants
                                    #include "/lib/materials/specificMaterials/terrain/copperBlock.glsl"
                                }
                            } else {
                                if (mat < 10300) { // Raw Gold Block
                                    #include "/lib/materials/specificMaterials/terrain/rawGoldBlock.glsl"
                                    #ifdef GLOWING_RAW_BLOCKS
                                        emission = color.g * 1.5;

                                        overlayNoiseIntensity = 0.65, overlayNoiseEmission = 0.6;
                                        #ifdef SITUATIONAL_ORES
                                            emission *= skyLightCheck;
                                            color.rgb = mix(color.rgb, color.rgb * pow(color.rgb, vec3(min1(GLOWING_ORE_MULT))), skyLightCheck);
                                        #else
                                            color.rgb *= pow(color.rgb, vec3(min1(GLOWING_ORE_MULT)));
                                        #endif
                                        emission *= GLOWING_ORE_MULT;
                                    #endif
                                }
                                else if (mat < 10302) { // Gold Ore
                                    if (color.r != color.g || color.r > 0.99) { // Gold Ore:Raw Gold Part
                                        #include "/lib/materials/specificMaterials/terrain/rawGoldBlock.glsl"
                                        #ifdef GLOWING_ORE_GOLD
                                            if (color.g - color.b > 0.15 || color.r > 0.99) {
                                                emission = color.r + 1.0;

                                                overlayNoiseIntensity = 0.65, overlayNoiseEmission = 0.6;
                                                #ifdef SITUATIONAL_ORES
                                                    emission *= skyLightCheck;
                                                    color.rgb = mix(color.rgb, color.rgb * pow(color.rgb, vec3(min1(GLOWING_ORE_MULT))), skyLightCheck);
                                                #else
                                                    color.rgb *= pow(color.rgb, vec3(min1(GLOWING_ORE_MULT)));
                                                #endif
                                                emission *= GLOWING_ORE_MULT;
                                            }
                                        #endif
                                    } else { // Gold Ore:Stone Part
                                        #include "/lib/materials/specificMaterials/terrain/stone.glsl"
                                    }
                                } else /*if (mat < 10302)*/ { // Deepslate Gold Ore
                                    if (color.r != color.g || color.r > 0.99) { // Deepslate Gold Ore:Raw Gold Part
                                        #include "/lib/materials/specificMaterials/terrain/rawGoldBlock.glsl"
                                        #ifdef GLOWING_ORE_GOLD
                                            if (color.g - color.b > 0.15 || color.r > 0.99) {
                                                emission = color.r + 1.0;

                                                overlayNoiseIntensity = 0.65, overlayNoiseEmission = 0.6;
                                                #ifdef SITUATIONAL_ORES
                                                    emission *= skyLightCheck;
                                                    color.rgb = mix(color.rgb, color.rgb * pow(color.rgb, vec3(min1(GLOWING_ORE_MULT))), skyLightCheck);
                                                #else
                                                    color.rgb *= pow(color.rgb, vec3(min1(GLOWING_ORE_MULT)));
                                                #endif
                                                emission *= GLOWING_ORE_MULT;
                                            }
                                        #endif
                                    } else { // Deepslate Gold Ore:Deepslate Part
                                        #include "/lib/materials/specificMaterials/terrain/deepslate.glsl"
                                    }
                                }
                            }
                        } else {
                            if (mat < 10312) {
                                if (mat < 10308) { // Pink and Purple Modded Ores
                                    // if (mat < 10306) { // Pink Modded Ores
                                        if (color.r - color.g > 0.1) { // Redstone Ore:Lit:Redstone Part
                                            #ifdef GLOWING_ORE_MODDED
                                                emission = min(1.5, pow2(color.r) * color.r * 4.5 * color.b);
                                                overlayNoiseIntensity = 0.5, overlayNoiseEmission = 0.5;
                                                #ifdef SITUATIONAL_ORES
                                                    emission *= skyLightCheck;
                                                #endif
                                            #endif
                                        } else { // Redstone Ore:Lit:Stone Part
                                            #include "/lib/materials/specificMaterials/terrain/stone.glsl"
                                        }
                                        noSmoothLighting = true;
                                    // } else { // Purple Modded Ores

                                    // }
                                }
                                else /*if (mat < 10312)*/ { // Nether Gold Ore
                                    if (color.g != color.b) { // Nether Gold Ore:Raw Gold Part
                                        #include "/lib/materials/specificMaterials/terrain/rawGoldBlock.glsl"
                                        #ifdef GLOWING_ORE_NETHERGOLD
                                            emission = color.g * 1.5;
                                            emission *= GLOWING_ORE_MULT;

                                            overlayNoiseIntensity = 0.65, overlayNoiseEmission = 0.6;
                                            #ifdef SITUATIONAL_ORES
                                                emission *= skyLightCheck;
                                            #endif
                                        #endif
                                    } else { // Nether Gold Ore:Netherrack Part
                                        #include "/lib/materials/specificMaterials/terrain/netherrack.glsl"
                                    }
                                }
                            } else {
                                if (mat < 10316) { // Gold Block, Light Weighted Pressure Plate
                                    #include "/lib/materials/specificMaterials/terrain/goldBlock.glsl"

                                    if (mat == 10315) { // Powered Light Weighted Pressure Plate
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                                else /*if (mat < 10320)*/ { // Diamond Block
                                    #include "/lib/materials/specificMaterials/terrain/diamondBlock.glsl"
                                }
                            }
                        }
                    }
                } else {
                    if (mat < 10352) {
                        if (mat < 10336) {
                            if (mat < 10328) {
                                if (mat < 10324) { // Diamond Ore
                                    if (color.b / color.r > 1.5 || color.b > 0.75) { // Diamond Ore:Diamond Part
                                        #include "/lib/materials/specificMaterials/terrain/diamondBlock.glsl"
                                        #ifdef GLOWING_ORE_DIAMOND
                                            emission = color.g + 1.5;

                                            overlayNoiseIntensity = 0.75, overlayNoiseEmission = 0.4;
                                            #ifdef SITUATIONAL_ORES
                                                emission *= skyLightCheck;
                                                color.rgb = mix(color.rgb, color.rgb * pow(color.rgb, vec3(min1(GLOWING_ORE_MULT))), skyLightCheck);
                                            #else
                                                color.rgb *= pow(color.rgb, vec3(min1(GLOWING_ORE_MULT)));
                                            #endif
                                            emission *= GLOWING_ORE_MULT;
                                        #endif
                                    } else { // Diamond Ore:Stone Part, Diamond Ore:StoneToDiamond part
                                        #include "/lib/materials/specificMaterials/terrain/stone.glsl"
                                    }
                                }
                                else /*if (mat < 10328)*/ { // Deepslate Diamond Ore
                                    if (color.b / color.r > 1.5 || color.b > 0.8) { // Deepslate Diamond Ore:Diamond Part
                                        #include "/lib/materials/specificMaterials/terrain/diamondBlock.glsl"
                                        #ifdef GLOWING_ORE_DIAMOND
                                            emission = color.g + 1.5;

                                            overlayNoiseIntensity = 0.75, overlayNoiseEmission = 0.4;
                                            #ifdef SITUATIONAL_ORES
                                                emission *= skyLightCheck;
                                                color.rgb = mix(color.rgb, color.rgb * pow(color.rgb, vec3(min1(GLOWING_ORE_MULT))), skyLightCheck);
                                            #else
                                                color.rgb *= pow(color.rgb, vec3(min1(GLOWING_ORE_MULT)));
                                            #endif
                                            emission *= GLOWING_ORE_MULT;
                                        #endif
                                    } else { // Deepslate Diamond Ore:Deepslate Part, Deepslate Diamond Ore:DeepslateToDiamond part
                                        #include "/lib/materials/specificMaterials/terrain/deepslate.glsl"
                                    }
                                }
                            } else {
                                if (mat < 10332) { // Amethyst Block, Budding Amethyst
                                    materialMask = OSIEBCA; // Intense Fresnel
                                    float factor = pow2(color.r);
                                    highlightMult = factor * 3.0;
                                    color.rgb *= 0.7 + 0.3 * GetLuminance(color.rgb);

                                    #if GLOWING_AMETHYST >= 2
                                        emission = dot(color.rgb, color.rgb) * 0.3;
                                        overlayNoiseEmission = 0.5;
                                    #endif
                                    
                                    #if ALTERNATIVE_AMETHYST_STYLE == 0
                                        smoothnessG = 0.8 - factor * 0.3;
                                        smoothnessD = factor;
                                    #elif ALTERNATIVE_AMETHYST_STYLE == 1
                                        smoothnessG = max(sqrt(1.0 - factor), 0.04);
                                        smoothnessD = factor * 2;
                                        color.rgb *= 1.75 - 0.4 * GetLuminance(color.rgb);
                                        color.g *= 0.85 * pow2(color.g);
                                        color.rgb = saturateColors(color.rgb, 0.6);
                                    #endif

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.66;
                                    #endif
                                }
                                else /*if (mat < 10336)*/ { // Amethyst Cluster, Amethyst Buds
                                    materialMask = OSIEBCA; // Intense Fresnel
                                    float factor = pow2(color.r);
                                    smoothnessG = 0.8 - factor * 0.3;
                                    highlightMult = factor * 3.0;
                                    smoothnessD = factor;

                                    noSmoothLighting = true;
                                    lmCoordM.x *= 0.85;

                                    #if GLOWING_AMETHYST >= 1
                                        #if defined GBUFFERS_TERRAIN && !defined IPBR_COMPATIBILITY_MODE
                                            vec3 worldPos = playerPos.xyz + cameraPosition.xyz;
                                            vec3 blockPos = abs(fract(worldPos) - vec3(0.5));
                                            float maxBlockPos = max(blockPos.x, max(blockPos.y, blockPos.z));
                                            emission = pow2(max0(1.0 - maxBlockPos * 1.85) * color.g) * 7.0;

                                            if (CheckForColor(color.rgb, vec3(254, 203, 230)))
                                                emission = pow(emission, max0(1.0 - 0.2 * max0(emission - 1.0)));

                                            color.g *= 1.0 - emission * 0.07;

                                            emission *= 1.3;
                                        #else
                                            emission = pow2(color.g + color.b) * 0.4;
                                        #endif

                                        overlayNoiseIntensity = 0.5;
                                    #endif

                                    #if ALTERNATIVE_AMETHYST_STYLE == 1
                                        color.rgb = pow1_5(color.rgb);
                                        color.rgb *= 1.5;
                                        color.g *= 0.6;
                                        color.rgb = saturateColors(color.rgb, 0.7);
                                    #endif                                

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.66;
                                    #endif
                                }
                            }
                        } else {
                            if (mat < 10344) {
                                if (mat < 10340) { // Emerald Block
                                    #include "/lib/materials/specificMaterials/terrain/emeraldBlock.glsl"

                                    #ifdef GLOWING_EMERALD_BLOCK
                                        emission = pow2(pow(color.g, 2.8)) * 3.0 + 0.3;
                                        color.rgb *= color.rgb;
                                        overlayNoiseIntensity = 0.5;
                                    #endif
                                }
                                else /*if (mat < 10344)*/ { // Emerald Ore
                                    float dif = GetMaxColorDif(color.rgb);
                                    if (dif > 0.25 || color.b > 0.85) { // Emerald Ore:Emerald Part
                                        #include "/lib/materials/specificMaterials/terrain/emeraldBlock.glsl"
                                        #ifdef GLOWING_ORE_EMERALD
                                            emission = 2.0;

                                            overlayNoiseIntensity = 0.7, overlayNoiseEmission = 0.3;
                                            #ifdef SITUATIONAL_ORES
                                                emission *= skyLightCheck;
                                                color.rgb = mix(color.rgb, color.rgb * pow(color.rgb, vec3(min1(GLOWING_ORE_MULT))), skyLightCheck);
                                            #else
                                                color.rgb *= pow(color.rgb, vec3(min1(GLOWING_ORE_MULT)));
                                            #endif
                                            emission *= GLOWING_ORE_MULT;
                                        #endif
                                    } else { // Emerald Ore:Stone Part
                                        #include "/lib/materials/specificMaterials/terrain/stone.glsl"
                                    }
                                }
                            } else {
                                if (mat < 10348) { // Deepslate Emerald Ore
                                    float dif = GetMaxColorDif(color.rgb);
                                    if (dif > 0.25 || color.b > 0.85) { // Deepslate Emerald Ore:Emerald Part
                                        #include "/lib/materials/specificMaterials/terrain/emeraldBlock.glsl"
                                        #ifdef GLOWING_ORE_EMERALD
                                            emission = 2.0;

                                            overlayNoiseIntensity = 0.7, overlayNoiseEmission = 0.3;
                                            #ifdef SITUATIONAL_ORES
                                                emission *= skyLightCheck;
                                                color.rgb = mix(color.rgb, color.rgb * pow(color.rgb, vec3(min1(GLOWING_ORE_MULT))), skyLightCheck);
                                            #else
                                                color.rgb *= pow(color.rgb, vec3(min1(GLOWING_ORE_MULT)));
                                            #endif
                                            emission *= GLOWING_ORE_MULT;
                                        #endif
                                    } else { // Deepslate Emerald Ore:Deepslate Part
                                        #include "/lib/materials/specificMaterials/terrain/deepslate.glsl"
                                    }
                                }
                                else /*if (mat < 10352)*/ { // Azalea, Flowering Azalea
                                    #include "/lib/materials/specificMaterials/terrain/cobblestone.glsl"
                                    sandNoiseIntensity = 0.3, mossNoiseIntensity = 0.0, isFoliage = true;

                                    #if EMISSIVE_FLOWERS > 0 && EMISSIVE_FLOWERS_TYPE < 2
                                        if (max(color.b, color.r * 0.7) > color.g) {
                                            emission = skyLightCheck;

                                            #if EMISSIVE_FLOWERS == 2
                                                emission = max(emission, rainFactor + 1.0 * rainFactor);
                                            #endif
                                            emission *= EMISSIVE_FLOWERS_STRENGTH;
                                        }
                                    #endif
                                }
                            }
                        }
                    } else {
                        if (mat < 10368) {
                            if (mat < 10360) {
                                if (mat < 10356) { // Lapis Block
                                    #include "/lib/materials/specificMaterials/terrain/lapisBlock.glsl"

                                    #ifdef EMISSIVE_LAPIS_BLOCK
                                        emission = pow2(dot(color.rgb, color.rgb)) * 10.0;

                                        overlayNoiseIntensity = 0.4, overlayNoiseEmission = 0.28;
                                    #endif
                                }
                                else /*if (mat < 10360)*/ { // Lapis Ore
                                    if (color.r != color.g) { // Lapis Ore:Lapis Part
                                        #include "/lib/materials/specificMaterials/terrain/lapisBlock.glsl"
                                        smoothnessG *= 0.5;
                                        smoothnessD *= 0.5;
                                        #ifdef GLOWING_ORE_LAPIS
                                            if (color.b - color.r > 0.2) {
                                                emission = 2.0;

                                                overlayNoiseIntensity = 0.65, overlayNoiseEmission = 0.6;
                                                #ifdef SITUATIONAL_ORES
                                                    emission *= skyLightCheck;
                                                    color.rgb = mix(color.rgb, color.rgb * pow(color.rgb, vec3(min1(GLOWING_ORE_MULT))), skyLightCheck);
                                                #else
                                                    color.rgb *= pow(color.rgb, vec3(min1(GLOWING_ORE_MULT)));
                                                #endif
                                                emission *= GLOWING_ORE_MULT;
                                            }
                                        #endif
                                    } else { // Lapis Ore:Stone Part
                                        #include "/lib/materials/specificMaterials/terrain/stone.glsl"
                                    }
                                }
                            } else {
                                if (mat < 10364) { // Deepslate Lapis Ore
                                    if (color.r != color.g) { // Deepslate Lapis Ore:Lapis Part
                                        #include "/lib/materials/specificMaterials/terrain/lapisBlock.glsl"
                                        smoothnessG *= 0.5;
                                        smoothnessD *= 0.5;
                                        #ifdef GLOWING_ORE_LAPIS
                                            if (color.b - color.r > 0.2) {
                                                emission = 2.0;

                                                overlayNoiseIntensity = 0.65, overlayNoiseEmission = 0.6;
                                                #ifdef SITUATIONAL_ORES
                                                    emission *= skyLightCheck;
                                                    color.rgb = mix(color.rgb, color.rgb * pow(color.rgb, vec3(min1(GLOWING_ORE_MULT))), skyLightCheck);
                                                #else
                                                    color.rgb *= pow(color.rgb, vec3(min1(GLOWING_ORE_MULT)));
                                                #endif
                                                emission *= GLOWING_ORE_MULT;
                                            }
                                        #endif
                                    } else { // Deepslate Lapis Ore:Deepslate Part
                                        #include "/lib/materials/specificMaterials/terrain/deepslate.glsl"
                                    }
                                }
                                else /*if (mat < 10368)*/ { // Quartz Block++
                                    #include "/lib/materials/specificMaterials/terrain/quartzBlock.glsl"
                                }
                            }
                        } else {
                            if (mat < 10376) {
                                if (mat < 10372) { // Nether Quartz Ore
                                    if (color.g != color.b) { // Nether Quartz Ore:Quartz Part
                                        #include "/lib/materials/specificMaterials/terrain/quartzBlock.glsl"
                                        #ifdef GLOWING_ORE_NETHERQUARTZ
                                            emission = pow2(color.b * 1.6);
                                            emission *= GLOWING_ORE_MULT;

                                            #ifdef SITUATIONAL_ORES
                                                emission *= skyLightCheck;
                                            #endif
                                        #endif
                                    } else { // Nether Quartz Ore:Netherrack Part
                                        #include "/lib/materials/specificMaterials/terrain/netherrack.glsl"
                                    }
                                }
                                else /*if (mat < 10376)*/ { // Obsidian
                                    #include "/lib/materials/specificMaterials/terrain/obsidian.glsl"
                                }
                            } else {
                                if (mat < 10380) { // Purpur Block+
                                    highlightMult = 2.0;
                                    smoothnessG = pow2(color.r) * 0.6;
                                    smoothnessG = min1(smoothnessG);
                                    smoothnessD = smoothnessG;

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.5;
                                    #endif
                                }
                                else /*if (mat < 10384)*/ { // 8 Layer Snow, Snow Block, Powder Snow
                                    #include "/lib/materials/specificMaterials/terrain/snow.glsl"

                                    overlayNoiseIntensity = 0.0;
                                }
                            }
                        }
                    }
                }
            } else {
                if (mat < 10448) {
                    if (mat < 10416) {
                        if (mat < 10400) {
                            if (mat < 10392) {
                                if (mat < 10388) { // Packed Ice
                                    materialMask = OSIEBCA; // Intense Fresnel
                                    float factor = pow2(color.g);
                                    float factor2 = pow2(factor);
                                    smoothnessG = 1.0 - 0.5 * factor;
                                    highlightMult = factor2 * 3.5;
                                    smoothnessD = factor;

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.33;
                                    #endif

                                    #ifdef SSS_SNOW_ICE
                                        subsurfaceMode = 3, noSmoothLighting = true, noDirectionalShading = true;
                                    #endif
                                }
                                else /*if (mat < 10392)*/ { // Blue Ice
                                    materialMask = OSIEBCA; // Intense Fresnel
                                    float factor = min1(pow2(color.g) * 1.38);
                                    float factor2 = pow2(factor);
                                    smoothnessG = 1.0 - 0.5 * factor;
                                    highlightMult = factor2 * 3.5;
                                    smoothnessD = pow1_5(color.g);

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.33;
                                    #endif

                                    #ifdef SSS_SNOW_ICE
                                        subsurfaceMode = 3, noSmoothLighting = true, noDirectionalShading = true;
                                    #endif
                                }
                            } else {
                                if (mat < 10396) { // Pumpkin, Carved Pumpkin
                                    #include "/lib/materials/specificMaterials/terrain/pumpkin.glsl"
                                }
                                else /*if (mat < 10400)*/ { // Jack o'Lantern
                                    #include "/lib/materials/specificMaterials/terrain/pumpkin.glsl"
                                    noSmoothLighting = true, noDirectionalShading = true;
                                    lmCoordM.y = 0.0;
                                    lmCoordM.x = 1.0;

                                    #if MC_VERSION >= 11300
                                        if (color.b > 0.28 && color.r > 0.9) {
                                            float factor = pow2(color.g);
                                            emission = pow2(factor) * factor * 5.0;
                                            #ifdef SOUL_SAND_VALLEY_OVERHAUL_INTERNAL
                                                color.rgb = changeColorFunction(color.rgb, 1.5, colorSoul, inSoulValley);
                                            #endif
                                            #ifdef PURPLE_END_FIRE_INTERNAL
                                                color.rgb = changeColorFunction(color.rgb, 1.5, colorEndBreath, 1.0);
                                            #endif
                                        }
                                    #else
                                        if (color.b < 0.4)
                                            emission = clamp01(color.g * 1.3 - color.r) * 5.0;
                                    #endif

                                    overlayNoiseIntensity = 0.3;

                                    #ifdef SPOOKY
                                        float noiseAdd = 0.0;
                                        #ifdef GBUFFERS_TERRAIN
                                            noiseAdd = hash13(mod(floor(worldPos + atMidBlock / 64) + frameTimeCounter * 0.000001, vec3(100)));
                                        #endif
                                        emission *= mix(0.0, 1.0, smoothstep(0.2, 0.9, texture2D(noisetex, vec2(frameTimeCounter * 0.025 + noiseAdd)).r));
                                    #endif
                                }
                            }
                        } else {
                            if (mat < 10408) {
                                if (mat < 10404) { // Sea Pickle:Not Waterlogged
                                    noSmoothLighting = true;

                                    overlayNoiseIntensity = 0.3;
                                }
                                else /*if (mat < 10408)*/ { // Sea Pickle:Waterlogged
                                    noSmoothLighting = true;

                                    overlayNoiseIntensity = 0.3;

                                    if (color.b > 0.5) { // Sea Pickle:Emissive Part
                                        #ifdef GBUFFERS_TERRAIN
                                            color.g *= 1.1;
                                            emission = 5.0;
                                        #endif
                                    }
                                }
                            } else {
                                if (mat < 10412) { // Basalt+
                                    smoothnessG = color.r * 0.45;
                                    smoothnessD = smoothnessG;

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.77;
                                    #endif
                                }
                                else /*if (mat < 10416)*/ { // Glowstone
                                    noSmoothLighting = true; noDirectionalShading = true;
                                    lmCoordM = vec2(0.9, 0.0);

                                    emission = max0(color.g - 0.3) * 4.6;
                                    color.rg += emission * vec2(0.15, 0.05);

                                    #ifdef DISTANT_LIGHT_BOKEH
                                        DoDistantLightBokehMaterial(emission, 2.0, lViewPos);
                                    #endif

                                    sandNoiseIntensity = 0.6, mossNoiseIntensity = 0.6;
                                }
                            }
                        }
                    } else {
                        if (mat < 10432) {
                            if (mat < 10424) {
                                if (mat < 10420) { // Nether Bricks+
                                    float factor = smoothstep1(min1(color.r * 1.5));
                                    factor = factor > 0.12 ? factor : factor * 0.5;
                                    smoothnessG = factor;
                                    smoothnessD = factor;
                                }
                                else /*if (mat < 10424)*/ { // Red Nether Bricks+
                                    float factor = color.r * 0.9;
                                    factor = color.r > 0.215 ? factor : factor * 0.25;
                                    smoothnessG = factor;
                                    smoothnessD = factor;

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.77;
                                    #endif
                                }
                            } else {
                                if (mat < 10428) { // Melon
                                    smoothnessG = color.r * 0.75;
                                    smoothnessD = color.r * 0.5;

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.66;
                                    #endif
                                }
                                else /*if (mat < 10432)*/ { // End Stone++,
                                    #include "/lib/materials/specificMaterials/terrain/endStone.glsl"
                                }
                            }
                        } else {
                            if (mat < 10440) {
                                if (mat < 10436) { // Terracotta+
                                    smoothnessG = 0.25;
                                    highlightMult = 1.5;
                                    smoothnessD = 0.17;

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.33;
                                    #endif
                                }
                                else /*if (mat < 10440)*/ { // Glazed Terracotta+
                                    smoothnessG = 0.75;
                                    smoothnessD = 0.35;

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.5;
                                    #endif
                                }
                            } else {
                                if (mat < 10444) { // Prismarine+, Prismarine Bricks+
                                    smoothnessG = pow2(color.g) * 0.8;
                                    highlightMult = 1.5;
                                    smoothnessD = smoothnessG;

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.66;
                                    #endif
                                }
                                else /*if (mat < 10448)*/ { // Dark Prismarine+
                                    smoothnessG = min1(pow2(color.g) * 2.0);
                                    highlightMult = 1.5;
                                    smoothnessD = smoothnessG;

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.77;
                                    #endif
                                }
                            }
                        }
                    }
                } else {
                    if (mat < 10480) {
                        if (mat < 10464) {
                            if (mat < 10456) {
                                if (mat < 10452) { // Sea Lantern
                                    noSmoothLighting = true; noDirectionalShading = true;
                                    lmCoordM.x = 0.85;

                                    smoothnessD = min1(max0(0.5 - color.r) * 2.0);
                                    smoothnessG = color.g;

                                    #ifndef IPBR_COMPATIBILITY_MODE
                                        float blockRes = absMidCoordPos.x * atlasSize.x;
                                        vec2 signMidCoordPosM = (floor((signMidCoordPos + 1.0) * blockRes) + 0.5) / blockRes - 1.0;
                                        float dotsignMidCoordPos = dot(signMidCoordPosM, signMidCoordPosM);
                                        float factor = pow2(max0(1.0 - 1.7 * pow2(pow2(dotsignMidCoordPos))));
                                    #else
                                        float factor = pow2(pow2(min(dot(color.rgb, color.rgb), 2.5) / 2.5));
                                    #endif
                                    
                                    emission = pow2(color.b) * 1.6 + 2.2 * factor;
                                    emission *= 0.4 + max0(0.6 - 0.006 * lViewPos);

                                    color.rb *= vec2(1.13, 1.1);

                                    #ifdef DISTANT_LIGHT_BOKEH
                                        DoDistantLightBokehMaterial(emission, 2.0, lViewPos);
                                    #endif

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.5;
                                    #endif

                                    overlayNoiseIntensity = 0.5;
                                }
                                else /*if (mat < 10456)*/ { // Magma Block
                                    noSmoothLighting = true; noDirectionalShading = true;
                                    lmCoordM = vec2(0.75, 0.0);

                                    if (color.g > 0.22) { // Emissive Part
                                        emission = pow2(pow2(color.r)) * 4.0;

                                        #if RAIN_PUDDLES >= 1 || defined SPOOKY_RAIN_PUDDLE_OVERRIDE
                                            noPuddles = color.g * 4.0;
                                        #endif

                                        color.gb *= max(2.0 - 11.0 * pow2(color.g), 0.5);

                                        maRecolor = vec3(emission * 0.075);

                                        overlayNoiseIntensity = 0.0;

                                        #ifdef SOUL_SAND_VALLEY_OVERHAUL_INTERNAL
                                            color.rgb = changeColorFunction(color.rgb, 2.0, colorSoul, inSoulValley);
                                        #endif
                                        #ifdef PURPLE_END_FIRE_INTERNAL
                                            color.rgb = changeColorFunction(color.rgb, 2.0, colorEndBreath, 1.0);
                                        #endif
                                    } else { // Netherrack Part
                                        #include "/lib/materials/specificMaterials/terrain/netherrack.glsl"

                                        emission = 0.2;
                                    }

                                }
                            } else {
                                if (mat < 10460) { // Command Block+
                                    color = texture2DLod(tex, texCoord, 0);

                                    vec2 coord = signMidCoordPos;
                                    float blockRes = absMidCoordPos.x * atlasSize.x;
                                    vec2 absCoord = abs(coord);
                                    float maxCoord = max(absCoord.x, absCoord.y);

                                    float dif = GetMaxColorDif(color.rgb);

                                    if ( // This mess exists because Iris' midCoord is slightly inaccurate
                                        dif > 0.1 && maxCoord < 0.375 &&
                                        !CheckForColor(color.rgb, vec3(111, 73, 43)) &&
                                        !CheckForColor(color.rgb, vec3(207, 166, 139)) &&
                                        !CheckForColor(color.rgb, vec3(155, 139, 207)) &&
                                        !CheckForColor(color.rgb, vec3(161, 195, 180)) &&
                                        !CheckForColor(color.rgb, vec3(201, 143, 107)) &&
                                        !CheckForColor(color.rgb, vec3(135, 121, 181)) &&
                                        !CheckForColor(color.rgb, vec3(131, 181, 145))
                                    ) {
                                        emission = 6.0;
                                        color.rgb *= color.rgb;
                                        highlightMult = 2.0;
                                        maRecolor = vec3(0.5);

                                        overlayNoiseIntensity = 0.1;
                                    } else {
                                        smoothnessG = dot(color.rgb, color.rgb) * 0.33;
                                        smoothnessD = smoothnessG;
                                    }
                                }
                                else /*if (mat < 10464)*/ { // Concrete+ except Lime
                                    smoothnessG = 0.4;
                                    highlightMult = 1.5;
                                    smoothnessD = 0.3;

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.2;
                                    #endif
                                }
                            }
                        } else {
                            if (mat < 10472) {
                                if (mat < 10468) { // Concrete Powder+
                                    smoothnessG = 0.2;
                                    smoothnessD = 0.1;

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.5;
                                    #endif
                                }
                                else /*if (mat < 10472)*/ { // Coral Block+
                                    #include "/lib/materials/specificMaterials/terrain/coral.glsl"
                                    // if (abs(color.r - color.g - color.b) < lColor * 0.49 || color.b > color.g) emission = (GetLuminance(color.rgb) - color.g * 0.6) * 2.5;
                                }
                            } else {
                                if (mat < 10476) { // Coral Fan+, Coral+
                                    noSmoothLighting = true;
                                    #include "/lib/materials/specificMaterials/terrain/coral.glsl"
                                    isFoliage = false;
                                }
                                else /*if (mat < 10480)*/ { // Crying Obsidian
                                    #include "/lib/materials/specificMaterials/terrain/cryingObsidian.glsl"

                                    #ifdef SNOWY_WORLD
                                        snowFactor = 0.0;
                                    #endif

                                    overlayNoiseIntensity = 0.7;
                                }
                            }
                        }
                    } else {
                        if (mat < 10496) {
                            if (mat < 10488) {
                                if (mat < 10484) { // Blackstone++
                                    #include "/lib/materials/specificMaterials/terrain/blackstone.glsl"

                                    if (mat == 10483) { // Powered Blackstone Redstone Components
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                                else /*if (mat < 10488)*/ { // Gilded Blackstone
                                    if (color.r > color.b * 3.0) { // Gilded Blackstone:Gilded Part
                                        #include "/lib/materials/specificMaterials/terrain/rawGoldBlock.glsl"
                                        #ifdef GLOWING_ORE_GILDEDBLACKSTONE
                                            emission = color.g * 1.5;
                                            emission *= GLOWING_ORE_MULT;

                                            overlayNoiseIntensity = 0.65, overlayNoiseEmission = 0.6;

                                            #ifdef SITUATIONAL_ORES
                                                emission *= skyLightCheck;
                                            #endif
                                        #endif
                                    } else { // Gilded Blackstone:Blackstone Part
                                        #include "/lib/materials/specificMaterials/terrain/blackstone.glsl"
                                    }

                                }
                            } else {
                                if (mat < 10492) { // Lily Pad
                                    noSmoothLighting = true;
                                    subsurfaceMode = 2;

                                    #if defined COATED_TEXTURES && defined GBUFFERS_TERRAIN
                                        doTileRandomisation = false;
                                    #endif

                                    #ifdef IPBR
                                        float factor = min1(color.g * 2.0);
                                        smoothnessG = factor * 0.5;
                                        highlightMult = factor;
                                    #endif
                                }
                                else /*if (mat < 10496)*/ { // Dirt Path
                                    #include "/lib/materials/specificMaterials/terrain/dirt.glsl"
                                    #ifdef GBUFFERS_TERRAIN
                                        glColor.a = sqrt(glColor.a);
                                    #endif
                                }
                            }
                        } else {
                            if (mat < 10504) {
                                if (mat < 10500) { // Torch
                                    noDirectionalShading = true;

                                    if (color.r > 0.95) {
                                        noSmoothLighting = true;
                                        lmCoordM.x = 1.0;
                                        emission = GetLuminance(color.rgb) * 4.1;
                                        #ifndef GBUFFERS_TERRAIN
                                            emission *= 0.65;
                                        #endif
                                        color.r *= 1.4;
                                        color.b *= 0.5;
                                        overlayNoiseIntensity = 0.0;

                                        #ifdef SOUL_SAND_VALLEY_OVERHAUL_INTERNAL
                                            if (color.g > 0.999) color.rgb = changeColorFunction(color.rgb, 1.5, colorSoul, inSoulValley);
                                        #endif
                                        #ifdef PURPLE_END_FIRE_INTERNAL
                                            if (color.g > 0.5) color.rgb = changeColorFunction(color.rgb, 2.0, colorEndBreath, 1.0);
                                        #endif
                                    } 
                                    
                                    #ifdef GBUFFERS_TERRAIN
                                        else if (abs(NdotU) < 0.5) {
                                            #ifndef IPBR_COMPATIBILITY_MODE
                                                #if MC_VERSION >= 12102 // torch model got changed in 1.21.2
                                                    lmCoordM.x = min1(0.7 + 0.3 * smoothstep1(max0(0.4 - signMidCoordPos.y)));
                                                #else
                                                    lmCoordM.x = min1(0.7 + 0.3 * pow2(1.0 - signMidCoordPos.y));
                                                #endif
                                            #else
                                                lmCoordM.x = 0.82;
                                            #endif
                                        }
                                    #else
                                        else {
                                            color.rgb *= 1.5;
                                        }
                                    #endif

                                    #ifdef DISTANT_LIGHT_BOKEH
                                        DoDistantLightBokehMaterial(color, vec4(1.0, 0.6, 0.2, 1.0), emission, 5.0, lViewPos);
                                    #endif

                                    emission += 0.0001; // No light reducing during noon
                                }
                                else /*if (mat < 10504)*/ { // End Rod
                                    noDirectionalShading = true;

                                    #ifdef GBUFFERS_TERRAIN
                                        noSmoothLighting = true;
                                        lmCoordM.x = 0.92;
                                    #else
                                        lmCoordM.x = 0.9;
                                    #endif

                                    float dotColor = dot(color.rgb, color.rgb);
                                    if (dotColor > 2.0) {
                                        emission = 3.3;
                                        emission *= 0.4 + max0(0.6 - 0.006 * lViewPos);
                                        vec2 noiseAdd = vec2(0.0);
                                        #if RAINBOW_END_ROD_COORD_OFFSET > 0 && defined GBUFFERS_TERRAIN
                                            noiseAdd = texture2D(noisetex, 0.00048 * (playerPos.xz + cameraPosition.xz)).rg;
                                            noiseAdd *= RAINBOW_END_ROD_COORD_OFFSET;
                                        #endif
                                        #if END_ROD_COLOR_PROFILE == 1
                                            color.rgb = pow2(vec3(END_ROD_R, END_ROD_G, END_ROD_B) / 255) * END_ROD_I;
                                        #elif END_ROD_COLOR_PROFILE == 2 || (END_ROD_COLOR_PROFILE == 3 && defined OVERWORLD)
                                            color.rgb = pow2(getRainbowColor(noiseAdd, END_ROD_RAINBOW_ANIMATE));
                                        #else
                                            color.rgb = pow2(color.rgb);
                                            color.g *= 0.95;
                                        #endif
                                    }

                                    #ifdef GBUFFERS_TERRAIN
                                        else { // Directional Self-light Effect
                                            vec3 fractPos = abs(fract(playerPos + cameraPosition) - 0.5);
                                            float maxCoord = max(fractPos.x, max(fractPos.y, fractPos.z));
                                            if (maxCoord < 0.4376) {
                                                lmCoordM.x = 1.0;
                                                color.rgb *= 1.8;
                                            }
                                        }
                                    #endif

                                    #ifdef DISTANT_LIGHT_BOKEH
                                        DoDistantLightBokehMaterial(emission, 4.0, lViewPos);
                                    #endif

                                    overlayNoiseIntensity = 0.3;
                                }
                            } else {
                                if (mat < 10508) { // Chorus Plant

                                }
                                else /*if (mat < 10512)*/ { // Chorus Flower:Alive
                                    float dotColor = dot(color.rgb, color.rgb);
                                    if (dotColor > 1.0) {
                                        emission = pow2(pow2(pow2(dotColor * 0.33))) + 0.2 * dotColor;
                                        overlayNoiseIntensity = 0.5, overlayNoiseEmission = 0.6;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    } else {
        if (mat < 10768) {
            if (mat < 10640) {
                if (mat < 10576) {
                    if (mat < 10544) {
                        if (mat < 10528) {
                            if (mat < 10520) {
                                if (mat < 10516) { // Chorus Flower:Dead
                                    vec3 checkColor = texture2DLod(tex, texCoord, 0).rgb;
                                    if (CheckForColor(checkColor, vec3(164, 157, 126)) ||
                                        CheckForColor(checkColor, vec3(201, 197, 176)) ||
                                        CheckForColor(checkColor, vec3(226, 221, 188)) ||
                                        CheckForColor(checkColor, vec3(153, 142, 95))
                                    ) {
                                        emission = min(GetLuminance(color.rgb), 0.75) / 0.75;
                                        emission = pow2(pow2(emission)) * 6.5;
                                        color.gb *= 0.85;

                                        overlayNoiseIntensity = 0.1, overlayNoiseEmission = 0.8;
                                    } else emission = max0(GetLuminance(color.rgb) - 0.5) * 3.0;
                                }
                                else /*if (mat < 10520)*/ { // Furnace:Lit
                                    lmCoordM.x *= 0.95;

                                    #include "/lib/materials/specificMaterials/terrain/cobblestone.glsl"

                                    float dotColor = dot(color.rgb, color.rgb);
                                    emission = 2.5 * dotColor * max0(pow2(pow2(pow2(color.r))) - color.b) + pow(dotColor * 0.35, 32.0);
                                    color.r *= 1.0 + 0.1 * emission;

                                    if (color.r > color.b * 2.0 && dotColor > 0.7) {
                                        #ifdef SOUL_SAND_VALLEY_OVERHAUL_INTERNAL
                                            color.rgb = changeColorFunction(color.rgb, 2.0, colorSoul, inSoulValley);
                                        #endif
                                        #ifdef PURPLE_END_FIRE_INTERNAL
                                            color.rgb = changeColorFunction(color.rgb, 2.0, colorEndBreath, 1.0);
                                        #endif
                                        overlayNoiseIntensity = 0.0;
                                    }
                                }
                            } else {
                                if (mat < 10524) { // Cactus
                                    float factor = sqrt1(color.r);
                                    smoothnessG = factor * 0.5;
                                    highlightMult = factor;

                                    mossNoiseIntensity = 0.0, sandNoiseIntensity = 0.3;
                                }
                                else /*if (mat < 10528)*/ { // Note Block, Jukebox
                                    float factor = color.r * 0.5;
                                    smoothnessG = factor;
                                    smoothnessD = factor;

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.66;
                                    #endif

                                    if (mat == 10526) { // Powered Note Block
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                            }
                        } else {
                            if (mat < 10536) {
                                if (mat < 10532) { // Soul Torch
                                    noSmoothLighting = true; noDirectionalShading = true;
                                    lmCoordM.x = min(lmCoordM.x * 0.9, 0.77);

                                    if (color.b > 0.6) {
                                        emission = 2.7;
                                        color.rgb = pow1_5(color.rgb);
                                        color.r = min1(color.r + 0.1);

                                        overlayNoiseIntensity = 0.0;
                                    }
                                    emission += 0.0001; // No light reducing during noon

                                    #ifdef DISTANT_LIGHT_BOKEH
                                        DoDistantLightBokehMaterial(color, vec4(0.5, 1.0, 1.0, 1.0), emission, 3.0, lViewPos);
                                    #endif

                                    #ifdef SNOWY_WORLD
                                        snowFactor = 0.0;
                                    #endif
                                }
                                else /*if (mat < 10536)*/ { // Brown Mushroom Block
                                    if (color.r > color.g && color.g > color.b && color.b > 0.37) {
                                        #include "/lib/materials/specificMaterials/terrain/cobblestone.glsl"
                                    } else {
                                        float factor = pow2(color.r) * color.r * 0.8;
                                        highlightMult = 1.5;
                                        smoothnessG = factor;
                                        smoothnessD = factor * 0.9;

                                        #ifdef COATED_TEXTURES
                                            noiseFactor = 0.33;
                                        #endif
                                    }
                                }
                            } else {
                                if (mat < 10540) { // Red Mushroom Block
                                    if (color.r > color.g && color.g > color.b && color.b > 0.37) {
                                        #include "/lib/materials/specificMaterials/terrain/cobblestone.glsl"
                                    } else {
                                        float factor = min1(pow2(color.g) + 0.25);
                                        highlightMult = 1.5;
                                        smoothnessG = factor;
                                        smoothnessD = factor * 0.7;

                                        #ifdef COATED_TEXTURES
                                            noiseFactor = 0.33;
                                        #endif
                                    }
                                }
                                else /*if (mat < 10544)*/ { // Mushroom Stem,
                                    if (color.r > color.g && color.g > color.b && color.b < 0.6) {
                                        #include "/lib/materials/specificMaterials/terrain/cobblestone.glsl"
                                    } else {
                                        float factor = pow2(pow2(color.g));
                                        highlightMult = 1.5;
                                        smoothnessG = factor;
                                        smoothnessD = factor * 0.5;

                                        #ifdef COATED_TEXTURES
                                            noiseFactor = 0.33;
                                        #endif
                                    }
                                }
                            }
                        }
                    } else {
                        if (mat < 10560) {
                            if (mat < 10552) {
                                if (mat < 10548) { // Glow Lichen
                                    noSmoothLighting = true;

                                    #if GLOWING_LICHEN > 0
                                        float dotColor = dot(color.rgb, color.rgb);
                                        emission = min(pow2(pow2(dotColor) * dotColor) * 1.4 + dotColor * 0.9, 6.0);
                                        emission = mix(emission, dotColor * 1.5, min1(lViewPos / 96.0)); // Less noise in the distance

                                        #if GLOWING_LICHEN == 1
                                            float skyLightFactor = pow2(1.0 - min1(lmCoord.y * 2.9));
                                            emission *= skyLightFactor;

                                            color.r *= 1.0 + 0.15 * skyLightFactor;
                                        #else
                                            color.r *= 1.15;
                                        #endif
                                    #endif

                                    sandNoiseIntensity = 0.0, mossNoiseIntensity = 0.0;
                                }
                                else /*if (mat < 10552)*/ { // Enchanting Table:Base
                                    float dotColor = dot(color.rgb, color.rgb);
                                    if (dotColor < 0.19 && color.r < color.b) {
                                        #include "/lib/materials/specificMaterials/terrain/obsidian.glsl"
                                    } else if (color.g >= color.r) {
                                        #include "/lib/materials/specificMaterials/terrain/diamondBlock.glsl"
                                        #ifdef EMISSIVE_ENCHANTING_TABLE
                                            emission = color.b + 0.4 + (1.0 - pow2(color.g)) * 0.8;
                                        #endif
                                    } else {
                                        smoothnessG = color.r * 0.3 + 0.1;
                                    }

                                    #ifdef SNOWY_WORLD
                                        snowFactor = 0.0;
                                    #endif
                                }
                            } else {
                                if (mat < 10556) { // End Portal Frame:Inactive
                                    noSmoothLighting = true;

                                    if (abs(color.r - color.g - 0.05) < 0.10) {
                                        #include "/lib/materials/specificMaterials/terrain/endStone.glsl"
                                    } else {
                                        #include "/lib/materials/specificMaterials/terrain/endPortalFrame.glsl"
                                    }

                                    #ifdef SNOWY_WORLD
                                        snowFactor = 0.0;
                                    #endif
                                }
                                else /*if (mat < 10560)*/ { // End Portal Frame:Active
                                    noSmoothLighting = true;

                                    if (abs(color.r - color.g - 0.05) < 0.10) {
                                        #include "/lib/materials/specificMaterials/terrain/endStone.glsl"
                                    } else {
                                        #include "/lib/materials/specificMaterials/terrain/endPortalFrame.glsl"

                                        vec2 absCoord = abs(fract(playerPos.xz + cameraPosition.xz) - 0.5);
                                        float maxCoord = max(absCoord.x, absCoord.y);
                                        if (maxCoord < 0.2505) { // End Portal Frame:Eye of Ender
                                            smoothnessG = 0.5;
                                            smoothnessD = 0.5;
                                            emission = pow2(min(color.g, 0.25)) * 170.0 * (0.28 - maxCoord);

                                            overlayNoiseIntensity = 0.65, overlayNoiseEmission = 0.6;
                                        } else {
                                            float minCoord = min(absCoord.x, absCoord.y);
                                            if (CheckForColor(color.rgb, vec3(153, 198, 147))
                                            && minCoord > 0.25) { // End Portal Frame:Emissive Corner Bits
                                                emission = 1.4;
                                                color.rgb = vec3(0.45, 1.0, 0.6);

                                                overlayNoiseIntensity = 0.65, overlayNoiseEmission = 0.6;
                                            }
                                        }
                                    }

                                    #ifdef SNOWY_WORLD
                                        snowFactor = 0.0;
                                    #endif
                                }
                            }
                        } else {
                            if (mat < 10568) {
                                if (mat < 10564) { // Lantern
                                    noSmoothLighting = true;
                                    lmCoordM.x = 0.77;

                                    #include "/lib/materials/specificMaterials/terrain/lanternMetal.glsl"

                                    emission = 4.3 * max0(color.r - color.b);
                                    emission += min(pow2(pow2(0.75 * dot(color.rgb, color.rgb))), 5.0);
                                    color.gb *= pow(vec2(0.8, 0.7), vec2(sqrt(emission) * 0.5));
                                    
                                    #ifdef DISTANT_LIGHT_BOKEH
                                        DoDistantLightBokehMaterial(color, vec4(1.0, 0.6, 0.2, 1.0), emission, 5.0, lViewPos);
                                    #endif

                                    #ifdef SNOWY_WORLD
                                        snowFactor = 0.0;
                                    #endif

                                    overlayNoiseIntensity = 0.0;

                                    #ifdef SS_BLOCKLIGHT // fix lanterns with custom models emitting blue light
                                        if (emission < 0.01) emission = 0.0;
                                    #endif

                                    #if defined SOUL_SAND_VALLEY_OVERHAUL_INTERNAL || defined PURPLE_END_FIRE_INTERNAL
                                        if(color.g > color.b){
                                            float uniformValue = 1.0;
                                            float gradient = 1.0;
                                            vec3 colorFire = vec3(0.0);
                                            #if defined NETHER
                                                #ifdef GBUFFERS_TERRAIN
                                                    float lanternOffset = 0.0;
                                                    if (mat == 10562) lanternOffset = 0.1; // Hanging Lantern
                                                    gradient = mix(1.0, 0.0, clamp01(blockUV.y - lanternOffset + 3.0 * blockUV.y - lanternOffset));
                                                #else
                                                    gradient = 0.0;
                                                #endif
                                                uniformValue = inSoulValley;
                                                colorFire = colorSoul;
                                            #endif
                                            #ifdef END
                                                colorFire = colorEndBreath;
                                            #endif
                                            color.rgb = mix(color.rgb, mix(color.rgb, vec3(GetLuminance(color.rgb)), 0.88), uniformValue * gradient);
                                            color.rgb *= mix(vec3(1.0), colorFire * 2.0, uniformValue * gradient);
                                        }
                                    #endif
                                }
                                else /*if (mat < 10568)*/ { // Soul Lantern
                                    noSmoothLighting = true;
                                    lmCoordM.x = min(lmCoordM.x, 0.77); // consistency748523

                                    #include "/lib/materials/specificMaterials/terrain/lanternMetal.glsl"

                                    emission = 1.45 * max0(color.g - color.r * 2.0);
                                    emission += 1.17 * min(pow2(pow2(0.55 * dot(color.rgb, color.rgb))), 3.5);

                                    #ifdef DISTANT_LIGHT_BOKEH
                                        DoDistantLightBokehMaterial(color, vec4(0.5, 1.0, 1.0, 1.0), emission, 3.0, lViewPos);
                                    #endif

                                    #ifdef SNOWY_WORLD
                                        snowFactor = 0.0;
                                    #endif

                                    overlayNoiseIntensity = 0.3;
                                }
                            } else {
                                if (mat < 10572) { // Turtle Egg, Sniffer Egg
                                    smoothnessG = (color.r + color.g) * 0.35;
                                    smoothnessD = (color.r + color.g) * 0.25;
                                }
                                else /*if (mat < 10576)*/ { // Dragon Egg
                                    #ifdef EMISSIVE_DRAGON_EGG
                                        emission = float(color.b > 0.1) * 10.0 + 1.25;
                                    #endif
                                }
                            }
                        }
                    }
                } else {
                    if (mat < 10608) {
                        if (mat < 10592) {
                            if (mat < 10584) {
                                if (mat < 10580) { // Smoker:Lit
                                    lmCoordM.x *= 0.95;

                                    float dotColor = dot(color.rgb, color.rgb);
                                    if (color.r > color.b * 2.0 && dotColor > 0.7) {
                                        emission = 2.5 * dotColor;
                                        color.r *= 1.5;

                                        overlayNoiseIntensity = 0.0;

                                        #ifdef SOUL_SAND_VALLEY_OVERHAUL_INTERNAL
                                            color.rgb = changeColorFunction(color.rgb, 2.0, colorSoul, inSoulValley);
                                        #endif
                                        #ifdef PURPLE_END_FIRE_INTERNAL
                                            color.rgb = changeColorFunction(color.rgb, 2.0, colorEndBreath, 1.0);
                                        #endif
                                    } else {
                                        #include "/lib/materials/specificMaterials/terrain/cobblestone.glsl"
                                    }
                                }
                                else /*if (mat < 10584)*/ { // Blast Furnace:Lit
                                    lmCoordM.x *= 0.95;

                                    float dotColor = dot(color.rgb, color.rgb);
                                    if (color.r > color.b * 2.0 && dotColor > 0.7) {
                                        emission = pow2(color.g) * (20.0 - 13.7 * float(color.b > 0.25));
                                        color.r *= 1.5;

                                        overlayNoiseIntensity = 0.0;

                                        #ifdef SOUL_SAND_VALLEY_OVERHAUL_INTERNAL
                                            color.rgb = changeColorFunction(color.rgb, 2.0, colorSoul, inSoulValley);
                                        #endif
                                        #ifdef PURPLE_END_FIRE_INTERNAL
                                            color.rgb = changeColorFunction(color.rgb, 2.0, colorEndBreath, 1.0);
                                        #endif
                                    } else {
                                        #include "/lib/materials/specificMaterials/terrain/cobblestone.glsl"
                                    }
                                }
                            } else {
                                if (mat < 10588) { // Coal Block
                                    smoothnessG = dot(color.rgb, vec3(0.5));
                                    smoothnessG = min1(smoothnessG);
                                    smoothnessD = smoothnessG;
                                }
                                else /*if (mat < 10592)*/ { // Respawn Anchor:Unlit
                                    noSmoothLighting = true;

                                    #include "/lib/materials/specificMaterials/terrain/cryingObsidian.glsl"
                                    emission += 0.2;

                                    #ifdef SNOWY_WORLD
                                        snowFactor = 0.0;
                                    #endif
                                }
                            }
                        } else {
                            if (mat < 10600) {
                                if (mat < 10596) { // Respawn Anchor:Lit
                                    noSmoothLighting = true;

                                    #include "/lib/materials/specificMaterials/terrain/cryingObsidian.glsl"

                                    vec2 absCoord = abs(signMidCoordPos);
                                    if (NdotU > 0.9 && max(absCoord.x, absCoord.y) < 0.754) { // Portal
                                        highlightMult = 0.0;
                                        smoothnessD = 0.0;
                                        emission = pow2(color.r) * color.r * 16.0;
                                        maRecolor = vec3(0.0);

                                        overlayNoiseIntensity = 0.0;
                                    } else if (color.r + color.g > 1.3) { // Respawn Anchor:Glowstone Part
                                        emission = 4.5 * sqrt3(max0(color.r + color.g - 1.3));
                                    }

                                    emission += 0.3;

                                    #ifdef SNOWY_WORLD
                                        snowFactor = 0.0;
                                    #endif
                                }
                                else /*if (mat < 10600)*/ { // Redstone Wire:Lit
                                    #include "/lib/materials/specificMaterials/terrain/redstoneBlock.glsl"

                                    #if COLORED_LIGHTING_INTERNAL == 0
                                        emission = pow2(min(color.r, 0.9)) * 4.0;
                                    #else
                                        vec3 colorP = color.rgb / glColor.rgb;
                                        emission = pow2((colorP.r + color.r) * 0.5) * 3.5;
                                    #endif

                                    color.gb *= 0.25;

                                    overlayNoiseIntensity = 0.0;
                                }
                            } else {
                                if (mat < 10604) { // Redstone Wire:Unlit
                                    #include "/lib/materials/specificMaterials/terrain/redstoneBlock.glsl"

                                    overlayNoiseIntensity = 0.0;
                                }
                                else /*if (mat < 10608)*/ { // Redstone Torch
                                    noSmoothLighting = true; noDirectionalShading = true;
                                    lmCoordM.x = min(lmCoordM.x * 0.9, 0.77);

                                    #include "/lib/materials/specificMaterials/terrain/redstoneTorch.glsl"
                                    emission += 0.0001; // No light reducing during noon

                                    #ifdef DISTANT_LIGHT_BOKEH
                                        DoDistantLightBokehMaterial(color, vec4(1.0, 0.0, 0.0, 1.0), emission, 5.0, lViewPos);
                                    #endif

                                    overlayNoiseIntensity = 0.0;
                                }
                            }
                        }
                    } else {
                        if (mat < 10624) {
                            if (mat < 10616) {
                                if (mat < 10612) { // Redstone Block
                                    #include "/lib/materials/specificMaterials/terrain/redstoneBlock.glsl"
                                    #ifdef EMISSIVE_REDSTONE_BLOCK
                                        emission = 0.75 + 3.0 * pow2(pow2(color.r));
                                        color.gb *= 0.65;

                                        #ifdef SNOWY_WORLD
                                            snowFactor = 0.0;
                                        #endif

                                        overlayNoiseIntensity = 0.5, sandNoiseIntensity = 0.5, mossNoiseIntensity = 0.5;
                                    #endif
                                }
                                else /*if (mat < 10616)*/ { // Redstone Ore:Unlit
                                    if (color.r - color.g > 0.2) { // Redstone Ore:Unlit:Redstone Part
                                        #include "/lib/materials/specificMaterials/terrain/redstoneBlock.glsl"
                                        #ifdef GLOWING_ORE_REDSTONE
                                            emission = color.r * pow1_5(color.r) * 4.0;

                                            overlayNoiseIntensity = 0.5, overlayNoiseEmission = 0.5;

                                            #ifdef SITUATIONAL_ORES
                                                emission *= skyLightCheck;
                                                color.gb = mix(color.gb, color.gb * (1.0 - 0.9 * min1(GLOWING_ORE_MULT)), skyLightCheck);
                                            #else
                                                color.gb *= 1.0 - 0.9 * min1(GLOWING_ORE_MULT);
                                            #endif
                                            emission *= GLOWING_ORE_MULT;
                                        #endif
                                    } else { // Redstone Ore:Unlit:Stone Part
                                        #include "/lib/materials/specificMaterials/terrain/stone.glsl"
                                    }
                                }
                            } else {
                                if (mat < 10620) { // Redstone Ore:Lit
                                    if (color.r - color.g > 0.2) { // Redstone Ore:Lit:Redstone Part
                                        #include "/lib/materials/specificMaterials/terrain/redstoneBlock.glsl"
                                        emission = pow2(color.r) * color.r * 5.5;
                                        color.gb *= 0.1;

                                        overlayNoiseIntensity = 0.5, overlayNoiseEmission = 0.5;
                                    } else { // Redstone Ore:Lit:Stone Part
                                        #include "/lib/materials/specificMaterials/terrain/stone.glsl"
                                    }
                                    noSmoothLighting = true;
                                }
                                else /*if (mat < 10624)*/ { // Deepslate Redstone Ore:Unlit
                                    if (color.r - color.g > 0.2) { // Deepslate Redstone Ore:Unlit:Redstone Part
                                        #include "/lib/materials/specificMaterials/terrain/redstoneBlock.glsl"
                                        #ifdef GLOWING_ORE_REDSTONE
                                            emission = color.r * pow1_5(color.r) * 4.0;

                                            overlayNoiseIntensity = 0.5, overlayNoiseEmission = 0.5;

                                            #ifdef SITUATIONAL_ORES
                                                emission *= skyLightCheck;
                                                color.gb = mix(color.gb, color.gb * (1.0 - 0.9 * min1(GLOWING_ORE_MULT)), skyLightCheck);
                                            #else
                                                color.gb *= 1.0 - 0.9 * min1(GLOWING_ORE_MULT);
                                            #endif
                                            emission *= GLOWING_ORE_MULT;
                                        #endif
                                    } else { // Deepslate Redstone Ore:Unlit:Deepslate Part
                                        #include "/lib/materials/specificMaterials/terrain/deepslate.glsl"
                                    }
                                }
                            }
                        } else {
                            if (mat < 10632) {
                                if (mat < 10628) { // Deepslate Redstone Ore:Lit
                                    if (color.r - color.g > 0.2) { // Deepslate Redstone Ore:Lit:Redstone Part
                                        #include "/lib/materials/specificMaterials/terrain/redstoneBlock.glsl"
                                        emission = pow2(color.r) * color.r * 6.0;
                                        color.gb *= 0.05;

                                        overlayNoiseIntensity = 0.5, overlayNoiseEmission = 0.5;
                                    } else { // Deepslate Redstone Ore:Lit:Deepslate Part
                                        #include "/lib/materials/specificMaterials/terrain/deepslate.glsl"
                                    }
                                    noSmoothLighting = true;
                                }
                                else /*if (mat < 10632)*/ { // Cave Vines:No Glow Berries
                                    subsurfaceMode = 1;
                                    lmCoordM.x *= 0.875;

                                    sandNoiseIntensity = 0.0, mossNoiseIntensity = 0.0, isFoliage = true;
                                }
                            } else {
                                if (mat < 10636) { // Cave Vines:With Glow Berries
                                    subsurfaceMode = 1;
                                    lmCoordM.x *= 0.875;

                                    if (color.r > 0.64) {
                                        emission = color.r < 0.75 ? 2.5 : 8.0;
                                        color.rgb = color.rgb * vec3(1.0, 0.8, 0.6);
                                        isFoliage = false;
                                    } else {
                                        isFoliage = true;
                                    }

                                    sandNoiseIntensity = 0.0, mossNoiseIntensity = 0.0;
                                }
                                else /*if (mat < 10640)*/ { // Redstone Lamp:Unlit
                                    materialMask = OSIEBCA; // Intense Fresnel
                                    smoothnessG = color.r * 0.5 + 0.2;
                                    float factor = pow2(smoothnessG);
                                    highlightMult = factor * 2.0 + 1.0;
                                    smoothnessD = min1(factor * 2.0);

                                    overlayNoiseIntensity = 0.3;
                                }
                            }
                        }
                    }
                }
            } else {
                if (mat < 10704) {
                    if (mat < 10672) {
                        if (mat < 10656) {
                            if (mat < 10648) {
                                if (mat < 10644) { // Redstone Lamp:Lit
                                    noDirectionalShading = true;
                                    lmCoordM.x = 0.84;

                                    materialMask = OSIEBCA; // Intense Fresnel
                                    smoothnessG = color.r * 0.35 + 0.2;
                                    float factor = pow2(smoothnessG);
                                    highlightMult = factor * 2.0 + 1.0;
                                    smoothnessD = min1(factor * 2.0);

                                    if (color.b > 0.1) {
                                        float dotColor = dot(color.rgb, color.rgb);
                                        #if MC_VERSION >= 11300
                                            emission = pow2(dotColor) * 1.0;
                                        #else
                                            emission = dotColor * 1.2;
                                        #endif
                                        color.rgb = pow1_5(color.rgb);
                                        maRecolor = vec3(emission * 0.2);

                                        overlayNoiseIntensity = 0.3;
                                    }

                                    #ifdef DISTANT_LIGHT_BOKEH
                                        DoDistantLightBokehMaterial(emission, 5.0, lViewPos);
                                    #endif
                                }
                                else /*if (mat < 10648)*/ { // Repeater, Comparator
                                    noSmoothLighting = true;
                                    
                                    #if ANISOTROPIC_FILTER > 0
                                        color = texture2D(tex, texCoord); // Fixes artifacts
                                        color.rgb *= glColor.rgb;
                                    #endif

                                    vec3 absDif = abs(vec3(color.r - color.g, color.g - color.b, color.r - color.b));
                                    float maxDif = max(absDif.r, max(absDif.g, absDif.b));
                                    if (maxDif > 0.125 || color.b > 0.99) { // Redstone Parts
                                        if (color.r < 0.999 && color.b > 0.4) color.gb *= 0.5; // Comparator:Emissive Wire

                                        #include "/lib/materials/specificMaterials/terrain/redstoneTorch.glsl"

                                        overlayNoiseIntensity = 0.7, overlayNoiseEmission = 0.2;
                                    } else { // Quartz Base
                                        float factor = pow2(color.g) * 0.6;

                                        smoothnessG = factor;
                                        highlightMult = 1.0 + 2.5 * factor;
                                        smoothnessD = factor;
                                    }
                                }
                            } else {
                                if (mat < 10652) { // Shroomlight
                                    noSmoothLighting = true; noDirectionalShading = true;
                                    lmCoordM = vec2(1.0, 0.0);

                                    float dotColor = dot(color.rgb, color.rgb);
                                    emission = min(pow2(pow2(pow2(dotColor * 0.6))), 6.0) * 0.8 + 0.5;

                                    #ifdef DISTANT_LIGHT_BOKEH
                                        DoDistantLightBokehMaterial(emission, 2.5, lViewPos);
                                    #endif

                                    overlayNoiseIntensity = 0.3;
                                }
                                else /*if (mat < 10656)*/ { // Campfire:Lit
                                    #ifdef GBUFFERS_TERRAIN
                                        vec3 fractPos = fract(playerPos + cameraPosition) - 0.5;
                                        lmCoordM.x = pow2(pow2(smoothstep1(1.0 - 0.4 * dot(fractPos.xz, fractPos.xz))));

                                        #ifdef LIGHTMAP_CURVES
                                            float campfireBrightnessFactor = mix(1.0, 0.9, clamp01(UPPER_LIGHTMAP_CURVE - 1.0));
                                            lmCoordM.x *= campfireBrightnessFactor;
                                        #endif
                                    #endif

                                    float dotColor = dot(color.rgb, color.rgb);
                                    if (color.r > color.b && color.r - color.g < 0.15 && dotColor < 1.4) {
                                        #include "/lib/materials/specificMaterials/terrain/oakWood.glsl"
                                    } else if (color.r > color.b || dotColor > 2.9) {
                                        noDirectionalShading = true;
                                        emission = 3.5;
                                        color.rgb *= sqrt1(GetLuminance(color.rgb));

                                        overlayNoiseIntensity = 0.0;

                                        #if defined SOUL_SAND_VALLEY_OVERHAUL_INTERNAL || defined PURPLE_END_FIRE_INTERNAL
                                            float uniformValue = 1.0;
                                            vec3 colorFire = vec3(0.0);
                                            float gradient = 0.0;
                                            #if defined NETHER
                                                uniformValue = inSoulValley;
                                                colorFire = colorSoul;
                                                #ifdef GBUFFERS_TERRAIN
                                                    gradient = mix(1.0, 0.0, clamp01(blockUV.y + 0.5 * blockUV.y));
                                                #elif defined GBUFFERS_HAND
                                                    float handUV = gl_FragCoord.y / viewHeight;
                                                    gradient = mix(1.0, 0.0, handUV + 0.4);
                                                #endif
                                            #endif
                                            #ifdef END 
                                                colorFire = colorEndBreath;
                                                #ifdef GBUFFERS_TERRAIN
                                                    gradient = mix(1.0, 0.0, clamp01(blockUV.y + 0.07 - 1.1 * clamp01(sin(texture2D(noisetex, vec2(frameTimeCounter * 0.01)).r) * blockUV.y)));
                                                #elif defined GBUFFERS_HAND
                                                    float handUV = gl_FragCoord.y / viewHeight;
                                                    gradient = mix(1.0, 0.0, clamp01(handUV + 0.3 - 1.3 * clamp01(sin(texture2D(noisetex, vec2(frameTimeCounter * 0.01)).r) * handUV)));
                                                #endif
                                            #endif
                                            color.rgb = mix(color.rgb, mix(color.rgb, vec3(GetLuminance(color.rgb)), 0.88), uniformValue * gradient);
                                            color.rgb *= mix(vec3(1.0), colorFire * 2.0, uniformValue * gradient);
                                        #endif
                                    }
                                }
                            }
                        } else {
                            if (mat < 10664) {
                                if (mat < 10660) { // Soul Campfire:Lit
                                    #if COLORED_LIGHTING_INTERNAL == 0
                                        noSmoothLighting = true;
                                    #else
                                        #ifdef GBUFFERS_TERRAIN
                                            vec3 fractPos = fract(playerPos + cameraPosition) - 0.5;
                                            lmCoordM.x = pow2(pow2(smoothstep1(1.0 - 0.4 * dot(fractPos.xz, fractPos.xz))));
                                            lmCoordM.x *= 0.95;
                                        #endif
                                    #endif

                                    float dotColor = dot(color.rgb, color.rgb);
                                    if (color.r > color.b) {
                                        #include "/lib/materials/specificMaterials/terrain/oakWood.glsl"
                                    } else if (color.g - color.r > 0.1 || dotColor > 2.9) {
                                        noDirectionalShading = true;
                                        emission = 2.1;
                                        color.rgb *= sqrt1(GetLuminance(color.rgb));

                                        overlayNoiseIntensity = 0.0;
                                    }

                                    #ifdef SNOWY_WORLD
                                        snowFactor = 0.0;
                                    #endif
                                }
                                else /*if (mat < 10664)*/ { // Campfire:Unlit, Soul Campfire:Unlit
                                    noSmoothLighting = true;

                                    if (color.r > color.b) {
                                        #include "/lib/materials/specificMaterials/terrain/oakWood.glsl"
                                    }
                                }
                            } else {
                                if (mat < 10668) { // Observer
                                    if (color.r > 0.1 && color.g + color.b < 0.1) {
                                        #include "/lib/materials/specificMaterials/terrain/redstoneTorch.glsl"

                                        overlayNoiseIntensity = 0.7, overlayNoiseEmission = 0.15;
                                    } else {
                                        #include "/lib/materials/specificMaterials/terrain/cobblestone.glsl"
                                    }
                                }
                                else if (mat < 10671) { // Wool+, Carpet+ except Lime, MV: Tripwire
                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.77;
                                    #endif
                                } else /*(mat == )*/ { // Tripwire
                                    redstoneIPBR(color.rgb, emission);
                                }
                            }
                        }
                    } else {
                        if (mat < 10688) {
                            if (mat < 10680) {
                                if (mat < 10676) { // Bone Block
                                    smoothnessG = color.r * 0.2;
                                    smoothnessD = smoothnessG;

                                    #ifdef GBUFFERS_TERRAIN
                                        DoBrightBlockTweaks(color.rgb, 0.5, shadowMult, highlightMult);
                                    #endif

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.33;
                                    #endif
                                }
                                else /*if (mat < 10680)*/ { // Barrel, Beehive, Bee Nest, Honeycomb Block
                                    #include "/lib/materials/specificMaterials/terrain/cobblestone.glsl"

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.66;
                                    #endif
                                }
                            } else {
                                if (mat < 10684) { // Ochre Froglight
                                    float frogPow = 8.0;
                                    #include "/lib/materials/specificMaterials/terrain/froglights.glsl"

                                    overlayNoiseIntensity = 0.3;
                                }
                                else /*if (mat < 10688)*/ { // Verdant Froglight
                                    float frogPow = 16.0;
                                    #include "/lib/materials/specificMaterials/terrain/froglights.glsl"

                                    overlayNoiseIntensity = 0.3;
                                }
                            }
                        } else {
                            if (mat < 10696) {
                                if (mat < 10692) { // Pearlescent Froglight
                                    float frogPow = 24.0;
                                    #include "/lib/materials/specificMaterials/terrain/froglights.glsl"

                                    overlayNoiseIntensity = 0.3;
                                }
                                else /*if (mat < 10696)*/ { // Reinforced Deepslate
                                    if (abs(color.r - color.g) < 0.01) { // Reinforced Deepslate:Deepslate Part
                                        #include "/lib/materials/specificMaterials/terrain/deepslate.glsl"
                                    } else { // Reinforced Deepslate:Sculk
                                        float boneFactor = max0(color.r * 1.25 - color.b);

                                        if (boneFactor < 0.0001) emission = 0.15;

                                        smoothnessG = min1(boneFactor * 1.7);
                                        smoothnessD = smoothnessG;
                                    }
                                }
                            } else {
                                //#define INTENSE_DEEP_DARK
                                if (mat < 10700) { // Sculk, Sculk Catalyst, Sculk Vein, Sculk Sensor:Unlit
                                    float boneFactor = max0(color.r * 1.25 - color.b);

                                    float sculkEmission = pow2(max0(color.g - color.r)) * 1.7;
                                    if (boneFactor < 0.0001) {
                                        overlayNoiseIntensity = 0.0;
                                        #ifdef INTENSE_DEEP_DARK
                                            emission = mix(sculkEmission, sculkEmission * 5.0, darknessFactor);
                                        #else
                                            emission = sculkEmission;
                                        #endif

                                        #ifdef GBUFFERS_TERRAIN
                                            vec2 bpos = floor(playerPos.xz + cameraPosition.xz + 0.501)
                                                    + floor(playerPos.y + cameraPosition.y + 0.501);
                                            bpos = bpos * 0.01 + 0.003 * frameTimeCounter;
                                            emission *= pow2(texture2D(noisetex, bpos).r * pow1_5(texture2D(noisetex, bpos * 0.5).r));
                                            emission *= 6.0;
                                        #endif
                                    }

                                    smoothnessG = min1(boneFactor * 1.7);
                                    smoothnessD = smoothnessG;

                                    #ifdef SNOWY_WORLD
                                        snowFactor = 0.0;
                                    #endif
                                }
                                else /*if (mat < 10704)*/ { // Sculk Shrieker
                                    float boneFactor = max0(color.r * 1.25 - color.b);

                                    if (boneFactor < 0.0001) {
                                        overlayNoiseIntensity = 0.0;
                                        float sculkEmission = pow2(max0(color.g - color.r)) * 2.0;
                                        #ifdef INTENSE_DEEP_DARK
                                            emission = mix(sculkEmission, sculkEmission * 3.0, darknessFactor);
                                        #else
                                            emission = sculkEmission;
                                        #endif

                                        #ifdef GBUFFERS_TERRAIN
                                            vec2 coordFactor = abs(fract(playerPos.xz + cameraPosition.xz) - 0.5);
                                            float coordFactorM = max(coordFactor.x, coordFactor.y);
                                            if (coordFactorM < 0.43) emission += color.g * 7.0;
                                        #endif
                                    }

                                    smoothnessG = min1(boneFactor * 1.7);
                                    smoothnessD = smoothnessG;

                                    #ifdef SNOWY_WORLD
                                        snowFactor = 0.0;
                                    #endif
                                }
                            }
                        }
                    }
                } else {
                    if (mat < 10736) {
                        if (mat < 10720) {
                            if (mat < 10712) {
                                if (mat < 10708) { // Sculk Sensor:Lit
                                    lmCoordM = vec2(0.0, 0.0);
                                    emission = pow2(max0(color.g - color.r)) * 7.0 + 0.7;

                                    overlayNoiseIntensity = 0.0;
                                    redstoneIPBR(color.rgb, emission);
                                }
                                else /*if (mat < 10712)*/ { // Spawner
                                    smoothnessG = color.b + 0.2;
                                    smoothnessD = smoothnessG;

                                    emission = 7.0 * float(CheckForColor(color.rgb, vec3(110, 4, 83)));

                                    overlayNoiseIntensity = 0.6, overlayNoiseEmission = 0.15;
                                }
                            } else {
                                if (mat < 10716) { // Tuff++
                                    smoothnessG = color.r * 0.4;
                                    smoothnessD = smoothnessG;
                                }
                                else /*if (mat < 10720)*/ { // Clay
                                    highlightMult = 2.0;
                                    smoothnessG = pow2(pow2(color.g)) * 0.5;
                                    smoothnessG = min1(smoothnessG);
                                    smoothnessD = smoothnessG * 0.7;

                                    #ifdef GBUFFERS_TERRAIN
                                        DoOceanBlockTweaks(smoothnessD);
                                    #endif

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.77;
                                    #endif
                                }
                            }
                        } else {
                            if (mat < 10728) {
                                if (mat < 10724) { // Ladder
                                    noSmoothLighting = true;
                                }
                                else /*if (mat < 10728)*/ { // Gravel, Suspicious Gravel
                                    #include "/lib/materials/specificMaterials/terrain/stone.glsl"

                                    #ifdef GBUFFERS_TERRAIN
                                        DoOceanBlockTweaks(smoothnessD);
                                    #endif

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 1.25;
                                    #endif
                                }
                            } else {
                                if (mat < 10732) { // Flower Pot, Potted Stuff:Without Subsurface
                                    noSmoothLighting = true;

                                    sandNoiseIntensity = 0.3, mossNoiseIntensity = 0.0;
                                }
                                else /*if (mat < 10736)*/ { // Potted Stuff:With Subsurface
                                    noSmoothLighting = true;

                                    float NdotE = dot(normalM, eastVec);
                                    if (abs(abs(NdotE) - 0.5) < 0.4) {
                                        subsurfaceMode = 1, noDirectionalShading = true, isFoliage = true;
                                    }

                                    sandNoiseIntensity = 0.3, mossNoiseIntensity = 0.0;

                                    #if defined GBUFFERS_TERRAIN && (EMISSIVE_FLOWERS > 0 || defined EMISSIVE_BLOOD_MOON_FLOWERS)
                                        if (mat == 10735 && blockUV.y > 0.4 && max(color.b, color.r * 1.3) > color.g) { // Potted Flowers
                                            isFoliage = false;
                                            #if EMISSIVE_FLOWERS > 0
                                                emission = 2.0 * skyLightCheck;
                                                #if EMISSIVE_FLOWERS == 2
                                                    emission = max(emission, rainFactor + 1.0 * rainFactor);
                                                #endif
                                                #if EMISSIVE_FLOWERS_TYPE == 1
                                                    if (color.b < max(color.r, color.g * 1.1) * 0.95) emission = 0.0;
                                                #elif EMISSIVE_FLOWERS_TYPE == 2
                                                    if (color.r < max(color.b * 1.15, color.g * 1.1) * 0.95) emission = 0.0;
                                                #endif
                                            #else
                                                emission *= int(color.r > max(color.b * 1.15, color.g * 2.5) * 0.95) * getBloodMoon(moonPhase, sunVisibility);
                                            #endif
                                            emission *= EMISSIVE_FLOWERS_STRENGTH;
                                        }
                                    #endif
                                }
                            }
                        }
                    } else {
                        if (mat < 10752) {
                            if (mat < 10744) {
                                if (mat < 10738) { // Pitcher Crop
                                    noSmoothLighting = true;
                                    sandNoiseIntensity = 0.3, mossNoiseIntensity = 0.0;

                                    #if EMISSIVE_FLOWERS > 0 && EMISSIVE_FLOWERS_TYPE < 2
                                        if (max(color.b * 1.25, color.r * 0.91) > color.g) { // Flowers
                                            emission = 1.5 * skyLightCheck;

                                            #if EMISSIVE_FLOWERS == 2
                                                emission = max(emission, rainFactor + 1.0 * rainFactor);
                                            #endif
                                            emission *= EMISSIVE_FLOWERS_STRENGTH;
                                        }
                                    #endif

                                    float NdotE = dot(normalM, eastVec);
                                    if (abs(abs(NdotE) - 0.5) < 0.4) {
                                        subsurfaceMode = 1, noDirectionalShading = true, isFoliage = true;
                                    } else {
                                        emission = 0.0;
                                    }
                                }
                                else if (mat < 10740) { // Structure Block, Jigsaw Block, Test Block, Test Instance Block
                                    float blockRes = absMidCoordPos.x * atlasSize.x;
                                    vec2 signMidCoordPosM = (floor((signMidCoordPos + 1.0) * blockRes) + 0.5) / blockRes - 1.0;
                                    float dotsignMidCoordPos = dot(signMidCoordPosM, signMidCoordPosM);
                                    float lBlockPosM = pow2(max0(1.0 - 1.125 * pow2(dotsignMidCoordPos)));

                                    emission = 2.5 * lBlockPosM + 1.0;
                                    color.rgb = mix(color.rgb, pow2(color.rgb), 0.5);

                                    overlayNoiseIntensity = 0.45, overlayNoiseEmission = 0.2;
                                }
                                else /*if (mat < 10744)*/ { // Chain
                                    noSmoothLighting = true;
                                    lmCoordM.x = min(lmCoordM.x, 0.77); // consistency748523

                                    #include "/lib/materials/specificMaterials/terrain/lanternMetal.glsl"
                                }
                            } else {
                                if (mat < 10748) { // Soul Sand, Soul Soil
                                    smoothnessG = color.r * 0.4;
                                    smoothnessD = color.r * 0.25;
                                    #if defined GBUFFERS_TERRAIN && defined EMISSIVE_SOUL_SAND
                                        vec3 playerPosM = playerPos + relativeEyePosition;
                                        if (length(playerPosM) < 3.0 && length(playerPosM.y) > 1.1)
                                        if (color.r < 0.26 && color.r > 0.257 && color.g < 0.2 && color.b < 0.17 && blockUV.y > 0.9999 // A lot of hardcoded stuff
                                        &&(blockUV.x > 0.625 && blockUV.z < 0.5 && blockUV.z > 0.375 
                                        || blockUV.x < 0.5 && blockUV.x > 0.25 && blockUV.z < 0.1875
                                        || blockUV.x < 0.375 && blockUV.z > 0.8125)) {
                                            float randomPos = step(0.5, hash13(mod(floor(worldPos + atMidBlock / 64) + frameTimeCounter * 0.0001, vec3(100))));
                                            vec2 flickerNoiseBlock = texture2D(noisetex, vec2(frameTimeCounter * 0.04)).rb;
                                            float noise = mix(1.0, min1(max(flickerNoiseBlock.r, flickerNoiseBlock.g) * 1.7), 0.6) * (clamp(3.0 / length(vec3(playerPosM.x * 1.5, playerPosM.y, playerPosM.z * 1.5)) - 1.0, 0.0, 0.25) * 2.0) * randomPos;
                                            color.rgb = changeColorFunction(color.rgb, 80.0, colorSoul, noise);
                                            emission = 4.0 * noise;
                                            overlayNoiseIntensity = 1.0 - noise;
                                        }
                                    #endif
                                }
                                else /*if (mat < 10752)*/ { // Dried Kelp Block
                                    smoothnessG = pow2(color.b) * 0.8;
                                    smoothnessD = smoothnessG;

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.5;
                                    #endif
                                }
                            }
                        } else {
                            if (mat < 10760) {
                                if (mat < 10756) { // Bamboo
                                    if (absMidCoordPos.x > 0.005)
                                        subsurfaceMode = 1, noSmoothLighting = true, noDirectionalShading = true;
                                    // No further material properties as bamboo jungles are already slow

                                    sandNoiseIntensity = 0.3, mossNoiseIntensity = 0.0, isFoliage = true;
                                }
                                else /*if (mat < 10760)*/ { // Block of Bamboo, Bamboo Planks++
                                    #include "/lib/materials/specificMaterials/planks/bambooPlanks.glsl"
                                    if (mat == 10759) { // Powered Bamboo Blocks
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                            } else {
                                if (mat < 10764) { // Cherry Planks++
                                    #include "/lib/materials/specificMaterials/planks/cherryPlanks.glsl"

                                    if (mat == 10763) { // Powered Cherry Redstone Components
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                                else /*if (mat < 10768)*/ { // Cherry Log, Cherry Wood
                                    if (color.g > 0.33) { // Cherry Log:Clean Part
                                        #include "/lib/materials/specificMaterials/planks/cherryPlanks.glsl"
                                    } else { // Cherry Log:Wood Part, Cherry Wood
                                        smoothnessG = pow2(color.r);
                                        smoothnessD = smoothnessG;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } else {
            if (mat < 10896) {
                if (mat < 10832) {
                    if (mat < 10800) {
                        if (mat < 10784) {
                            if (mat < 10776) {
                                if (mat < 10772) { // Torchflower
                                    #include "/lib/materials/specificMaterials/terrain/torchflower.glsl"
                                }
                                else /*if (mat < 10776)*/ { // Potted Torchflower
                                    noSmoothLighting = true;

                                    float NdotE = dot(normalM, eastVec);
                                    if (abs(abs(NdotE) - 0.5) < 0.4) {
                                        #include "/lib/materials/specificMaterials/terrain/torchflower.glsl"
                                    }
                                }
                            } else {
                                if (mat < 10780) { // Crimson Fungus, Warped Fungus
                                    noSmoothLighting = true;

                                    if (color.r > 0.91) {
                                        emission = 3.0 * color.g;
                                        color.r *= 1.2;
                                        maRecolor = vec3(0.1);

                                        overlayNoiseIntensity = 0.5;
                                    }

                                    sandNoiseIntensity = 0.3, mossNoiseIntensity = 0.0; isFoliage = false;
                                }
                                else /*if (mat < 10784)*/ { // Potted Crimson Fungus, Potted Warped Fungus
                                    noSmoothLighting = true;

                                    float NdotE = dot(normalM, eastVec);
                                    if (abs(abs(NdotE) - 0.5) < 0.4) {
                                        if (color.r > 0.91) {
                                            emission = 3.0 * color.g;
                                            color.r *= 1.2;
                                            maRecolor = vec3(0.1);
                                        }
                                    }

                                    sandNoiseIntensity = 0.3, mossNoiseIntensity = 0.0;
                                }
                            }
                        } else {
                            if (mat < 10792) {
                                if (mat < 10788) { // Calibrated Sculk Sensor:Unlit
                                    #if ANISOTROPIC_FILTER == 0
                                        vec4 checkColor = color;
                                    #else
                                        vec4 checkColor = texture2D(tex, texCoord); // Fixes artifacts
                                    #endif
                                    if (checkColor.r + checkColor.b > checkColor.g * 2.2 || checkColor.r > 0.99) { // Amethyst Part
                                        #if GLOWING_AMETHYST >= 1
                                            #if defined GBUFFERS_TERRAIN && !defined IPBR_COMPATIBILITY_MODE
                                                vec2 absCoord = abs(signMidCoordPos);
                                                float maxBlockPos = max(absCoord.x, absCoord.y);
                                                emission = pow2(max0(1.0 - maxBlockPos) * color.g) * 5.4 + 1.2 * color.g;

                                                color.g *= 1.0 - emission * 0.07;
                                                color.rgb *= color.g;
                                            #else
                                                emission = pow2(color.g + color.b) * 0.32;
                                            #endif
                                        #endif

                                        #ifdef COATED_TEXTURES
                                            noiseFactor = 0.66;
                                        #endif
                                    } else { // Sculk Part
                                        float boneFactor = max0(color.r * 1.25 - color.b);

                                        if (boneFactor < 0.0001) emission = pow2(max0(color.g - color.r));

                                        smoothnessG = min1(boneFactor * 1.7);
                                        smoothnessD = smoothnessG;
                                    }

                                    #ifdef SNOWY_WORLD
                                        snowFactor = 0.0;
                                    #endif

                                    overlayNoiseIntensity = 0.0;
                                }
                                else /*if (mat < 10792)*/ { // Calibrated Sculk Sensor:Lit
                                    lmCoordM = vec2(0.0, 0.0);

                                    #if ANISOTROPIC_FILTER == 0
                                        vec4 checkColor = color;
                                    #else
                                        vec4 checkColor = texture2D(tex, texCoord); // Fixes artifacts
                                    #endif
                                    if (checkColor.r + checkColor.b > checkColor.g * 2.2 || checkColor.r > 0.99) { // Amethyst Part
                                        lmCoordM.x = 1.0;

                                        #if GLOWING_AMETHYST >= 1
                                            #if defined GBUFFERS_TERRAIN && !defined IPBR_COMPATIBILITY_MODE
                                                vec2 absCoord = abs(signMidCoordPos);
                                                float maxBlockPos = max(absCoord.x, absCoord.y);
                                                emission = pow2(max0(1.0 - maxBlockPos) * color.g) * 5.4 + 1.2 * color.g;

                                                color.g *= 1.0 - emission * 0.07;
                                                color.rgb *= color.g;
                                            #else
                                                emission = pow2(color.g + color.b) * 0.32;
                                            #endif
                                        #endif

                                        #ifdef COATED_TEXTURES
                                            noiseFactor = 0.66;
                                        #endif
                                    } else { // Sculk Part
                                        emission = pow2(max0(color.g - color.r)) * 7.0 + 0.7;
                                    }

                                    overlayNoiseIntensity = 0.0;
                                    redstoneIPBR(color.rgb, emission);
                                }
                            } else {
                                if (mat < 10796) { // Oak Door
                                    noSmoothLighting = true;
                                    #include "/lib/materials/specificMaterials/planks/oakPlanks.glsl"

                                    if (mat == 10795) { // Powered Oak Door
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                                else /*if (mat < 10800)*/ { // Spruce Door
                                    noSmoothLighting = true;
                                    #include "/lib/materials/specificMaterials/planks/sprucePlanks.glsl"

                                    if (mat == 10799) { // Powered Spruce Door
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                            }
                        }
                    } else {
                        if (mat < 10816) {
                            if (mat < 10808) {
                                if (mat < 10804) { // Birch Door
                                    noSmoothLighting = true;
                                    #include "/lib/materials/specificMaterials/planks/birchPlanks.glsl"

                                    if (mat == 10803) { // Powered Birch Door
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                                else /*if (mat < 10808)*/ { // Jungle Door
                                    noSmoothLighting = true;
                                    #include "/lib/materials/specificMaterials/planks/junglePlanks.glsl"

                                    if (mat == 10807) { // Powered Jungle Door
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                            } else {
                                if (mat < 10812) { // Acacia Door
                                    noSmoothLighting = true;
                                    #include "/lib/materials/specificMaterials/planks/acaciaPlanks.glsl"

                                    if (mat == 10811) { // Powered Acacia Door
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                                else /*if (mat < 10816)*/ { // Dark Oak Door
                                    noSmoothLighting = true;
                                    #include "/lib/materials/specificMaterials/planks/darkOakPlanks.glsl"

                                    if (mat == 10815) { // Powered Dark Oak Door
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                            }
                        } else {
                            if (mat < 10824) {
                                if (mat < 10820) { // Mangrove Door
                                    noSmoothLighting = true;
                                    #include "/lib/materials/specificMaterials/planks/mangrovePlanks.glsl"

                                    if (mat == 10819) { // Powered Mangrove Door
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                                else /*if (mat < 10824)*/ { // Crimson Door
                                    noSmoothLighting = true;
                                    #include "/lib/materials/specificMaterials/planks/crimsonPlanks.glsl"

                                    if (mat == 10823) { // Powered Crimson Door
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                            } else {
                                if (mat < 10828) { // Warped Door
                                    noSmoothLighting = true;
                                    #include "/lib/materials/specificMaterials/planks/warpedPlanks.glsl"

                                    if (mat == 10827) { // Powered Warped Door
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                                else /*if (mat < 10832)*/ { // Bamboo Door
                                    noSmoothLighting = true;
                                    #include "/lib/materials/specificMaterials/planks/bambooPlanks.glsl"

                                    if (mat == 10831) { // Powered Bamboo Door
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                            }
                        }
                    }
                } else {
                    if (mat < 10864) {
                        if (mat < 10848) {
                            if (mat < 10840) {
                                if (mat < 10836) { // Cherry Door, Cherry Trapdoor
                                    noSmoothLighting = true;
                                    #include "/lib/materials/specificMaterials/planks/cherryPlanks.glsl"

                                    if (mat == 10835) { // Powered Cherry Door and Cherry Trapdoor
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                                else /*if (mat < 10840)*/ { // Brewing Stand
                                    #ifdef GBUFFERS_TERRAIN
                                        vec3 worldPos = playerPos + cameraPosition;
                                        vec3 fractPos = fract(worldPos.xyz);
                                        vec3 coordM = abs(fractPos.xyz - 0.5);
                                        float cLength = dot(coordM, coordM) * 1.3333333;
                                        cLength = pow2(1.0 - cLength);

                                        if (color.r + color.g > color.b * 3.0 && max(coordM.x, coordM.z) < 0.07) {
                                            emission = 2.5 * pow1_5(cLength);
                                        } else {
                                            lmCoordM.x = max(lmCoordM.x * 0.9, cLength);

                                            #include "/lib/materials/specificMaterials/terrain/cobblestone.glsl"
                                        }
                                    #else
                                        emission = max0(color.r + color.g - color.b * 1.8 - 0.3) * 2.2;
                                    #endif

                                    overlayNoiseIntensity = 0.0;

                                    #ifdef SOUL_SAND_VALLEY_OVERHAUL_INTERNAL
                                        color.rgb = changeColorFunction(color.rgb, 2.0, colorSoul, inSoulValley);
                                    #endif
                                    #ifdef PURPLE_END_FIRE_INTERNAL
                                        color.rgb = changeColorFunction(color.rgb, 2.0, colorEndBreath, 1.0);
                                    #endif
                                }
                            } else {
                                if (mat < 10841) { // Lime Concrete
                                    smoothnessG = 0.4;
                                    highlightMult = 1.5;
                                    smoothnessD = 0.3;

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.2;
                                    #endif

                                    #ifdef GREEN_SCREEN_LIME
                                        materialMask = OSIEBCA * 240.0; // Green Screen Lime Blocks
                                    #endif
                                }
                                else if (mat < 10844) { // Blue Carpet, Blue Wool
                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.77;
                                    #endif

                                    #ifdef BLUE_SCREEN
                                        materialMask = OSIEBCA * 239.0; // Blue Screen Blue Blocks
                                    #endif
                                }
                                else if (mat < 10846) { // Lime Carpet, Lime Wool, MV: Green stuff
                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.77;
                                    #endif

                                    #ifdef GREEN_SCREEN_LIME
                                        materialMask = OSIEBCA * 240.0; // Green Screen Lime Blocks
                                    #endif
                                }
                                else /*if (mat < 10847)*/ { // Blue Concrete
                                    smoothnessG = 0.4;
                                    highlightMult = 1.5;
                                    smoothnessD = 0.3;

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.2;
                                    #endif

                                    #ifdef BLUE_SCREEN
                                        materialMask = OSIEBCA * 239.0; // Blue Screen Blue Blocks
                                    #endif
                                }
                            }
                        } else {
                            if (mat < 10856) {
                                if (mat < 10852) { // Crafter
                                    smoothnessG = pow2(color.b);
                                    smoothnessD = max(smoothnessG, 0.2);

                                    if (color.r > 2.5 * (color.g + color.b)) {
                                        emission = 4.0;
                                        color.rgb *= color.rgb;
                                    }
                                }
                                else /*if (mat < 10856)*/ { // Copper Bulb:BrighterOnes
                                    #include "/lib/materials/specificMaterials/terrain/copperBulb.glsl"
                                }
                            } else {
                                if (mat < 10860) { // Copper Bulb:DimmerOnes
                                    #include "/lib/materials/specificMaterials/terrain/copperBulb.glsl"
                                    emission *= 0.85;
                                }
                                else /*if (mat < 10864)*/ { // Copper Door+, Copper Trapdoor+
                                    noSmoothLighting = true;
                                    #include "/lib/materials/specificMaterials/terrain/copperBlock.glsl"

                                    if (mat == 10863) { // Powered Copper Door+, Copper Trapdoor+
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                            }
                        }
                    } else {
                        if (mat < 10880) {
                            if (mat < 10872) {
                                if (mat < 10868) { // Copper Trapdoor+
                                    #include "/lib/materials/specificMaterials/terrain/copperBlock.glsl"
                                }
                                else /*if (mat < 10872)*/ { // Trial Spawner:NotOminous:Active, Vault:NotOminous:Active
                                    smoothnessG = max0(color.b - color.r * 0.5);
                                    smoothnessD = smoothnessG;

                                    emission = max0(color.r - color.b) * 3.0;
                                    color.rgb = pow(color.rgb, vec3(1.0 + 0.5 * sqrt(emission)));
                                }
                            } else {
                                if (mat < 10876) { // Trial Spawner:Inactive, Vault:Inactive
                                    smoothnessG = max0(color.b - color.r * 0.5);
                                    smoothnessD = smoothnessG;
                                }
                                else /*if (mat < 10880)*/ { // Trial Spawner:Ominous:Active, Vault:Ominous:Active
                                    float maxComponent = max(max(color.r, color.g), color.b);
                                    float minComponent = min(min(color.r, color.g), color.b);
                                    float saturation = (maxComponent - minComponent) / (1.0 - abs(maxComponent + minComponent - 1.0));

                                    smoothnessG = max0(color.b - pow2(saturation) * 0.5) * 0.5 + 0.1;
                                    smoothnessD = smoothnessG;

                                    emission = saturation > 0.5 ? 4.0 : 0.0;
                                    color.rgb = pow(color.rgb, vec3(1.0 + (0.3 + 0.5 * color.r) * emission));
                                }
                            }
                        } else {
                            if (mat < 10888) {
                                if (mat < 10884) { //

                                }
                                else /*if (mat < 10888)*/ { // Weeping Vines, Twisting Vines
                                    noSmoothLighting = true;

                                    #if defined COATED_TEXTURES && defined GBUFFERS_TERRAIN
                                        doTileRandomisation = false;
                                    #endif

                                    if (color.r > 0.91 && mat == 10884) {
                                        emission = 3.0 * color.g;
                                        color.r *= 1.2;
                                        maRecolor = vec3(0.1);
                                    }
                                    isFoliage = false;
                                }
                            } else {
                                if (mat < 10891) { // Hay Block
                                    smoothnessG = pow2(color.r) * 0.5;
                                    highlightMult *= 1.5;
                                    smoothnessD = float(color.r > color.g * 2.0) * 0.3;
                                }
                                else /*if (mat < 10896)*/ { // Iron Door
                                    noSmoothLighting = true;
                                    #include "/lib/materials/specificMaterials/terrain/ironBlock.glsl"
                                    color.rgb *= 0.9;
                                    if (mat == 10893) { // Powered Iron Door and Iron Trapdoor
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                            }
                        }
                    }
                }
            } else {
                if (mat < 10960) {
                    if (mat < 10928) {
                        if (mat < 10900) { // Iron Trapdoor
                            #include "/lib/materials/specificMaterials/terrain/ironBlock.glsl"
                            color.rgb *= 0.9;
                                    if (mat == 10899) { // Powered Iron Door and Iron Trapdoor
                                        redstoneIPBR(color.rgb, emission);
                                    }
                        }
                        else if (mat < 10923) { // Candles:Lit, Candle Cakes:Lit
                            #include "/lib/materials/specificMaterials/terrain/candle.glsl"
                        }
                        else if (mat < 10924) { // Pale Hanging Moss
                            subsurfaceMode = 3, centerShadowBias = true; noSmoothLighting = true;

                            #if defined COATED_TEXTURES && defined GBUFFERS_TERRAIN
                                doTileRandomisation = false;
                            #endif

                            float factor = color.g;
                            smoothnessG = factor * 0.5;
                            highlightMult = factor * 4.0 + 2.0;
                            float fresnel = clamp(1.0 + dot(normalM, normalize(viewPos)), 0.0, 1.0);
                            highlightMult *= 1.0 - pow2(pow2(fresnel));

                            sandNoiseIntensity = 0.3, mossNoiseIntensity = 0.0, isFoliage = true;
                        }
                        else /*if (mat < 10928)*/ { //
                            
                        }
                    } else {
                        if (mat < 10944) {
                            if (mat < 10936) {
                                if (mat < 10932) { // Pale Oak Planks++
                                    #include "/lib/materials/specificMaterials/planks/paleOakPlanks.glsl"
                                }
                                else /*if (mat < 10936)*/ { // // Pale Oak Log, Pale Oak Wood
                                    if (color.g > 0.45) { // Pale Oak Log:Clean Part
                                        #include "/lib/materials/specificMaterials/planks/paleOakPlanks.glsl"
                                    } else { // Pale Oak Log:Wood Part, Pale Oak Wood
                                        #include "/lib/materials/specificMaterials/terrain/paleOakWood.glsl"
                                    }
                                }
                            } else {
                                if (mat < 10940) { // Pale Oak Door
                                    noSmoothLighting = true;
                                    #include "/lib/materials/specificMaterials/planks/paleOakPlanks.glsl"
                                }
                                else /*if (mat < 10944)*/ { // Resin++
                                    smoothnessG = color.r * 0.25;
                                    smoothnessD = smoothnessG;
                                }
                            }
                        } else {
                            if (mat < 10952) {
                                if (mat < 10948) { // Creaking Heart: Inactive
                                    #include "/lib/materials/specificMaterials/terrain/paleOakWood.glsl"
                                }
                                else /*if (mat < 10952)*/ { // Creaking Heart: Active
                                    #include "/lib/materials/specificMaterials/terrain/paleOakWood.glsl"

                                    if (color.r + color.g > color.b * 4.0) {
                                        emission = pow2(color.r) * 2.5 + 0.2;
                                    }
                                }
                            } else {
                                if (mat < 10956) { // Snow: Layers 1 to 7
                                    #include "/lib/materials/specificMaterials/terrain/snow.glsl"

                                    #if defined GBUFFERS_TERRAIN && defined TAA
                                        float snowFadeOut = 0.0;
                                        snowFadeOut = clamp01((playerPos.y) * 0.1);
                                        snowFadeOut *= clamp01((lViewPos - 64.0) * 0.01);

                                        if (dither + 0.25 < snowFadeOut) discard;
                                    #endif
                                }
                                else /*if (mat < 10960)*/ { // Target Block: Inactive
                                    smoothnessG = pow2(color.r) * 0.5;
                                    smoothnessD = smoothnessG * 0.5;
                                }
                            }
                        }
                    }
                } else {
                    if (mat < 10992) {
                        if (mat < 10976) {
                            if (mat < 10968) {
                                if (mat < 10964) { // Target Block: Active
                                    smoothnessG = pow2(color.r) * 0.5;
                                    smoothnessD = smoothnessG * 0.5;

                                    if (color.r > color.g + color.b) {
                                        if (CheckForColor(color.rgb, vec3(220, 74, 74))) {
                                            emission = 5.0;
                                            color.rgb *= mix(vec3(1.0), pow2(color.rgb), 0.9);
                                        } else {
                                            emission = 3.0;
                                            color.rgb *= pow2(color.rgb);
                                        }
                                    }
                                }
                                else /*if (mat < 10968)*/ { // Sponge
                                    smoothnessG = pow2(color.g) * 0.2;
                                    smoothnessD = smoothnessG * 0.5;
                                }
                            } else {
                                if (mat < 10972) { // Wet Sponge
                                    smoothnessG = color.g * 0.75;
                                    highlightMult = 0.3;
                                    smoothnessD = smoothnessG * 0.25;
                                }
                                else /*if (mat < 10976)*/ { // Firefly Bush
                                    subsurfaceMode = 1, noSmoothLighting = true, noDirectionalShading = true;

                                    #if defined COATED_TEXTURES && defined GBUFFERS_TERRAIN
                                        doTileRandomisation = false;
                                    #endif

                                    color.rgb *= 1.5;
                                }
                            }
                        } else {
                            if (mat < 10984) {
                                if (mat < 10980) { // Open Eyeblossom
                                    #include "/lib/materials/specificMaterials/terrain/openEyeblossom.glsl"
                                }
                                else /*if (mat < 10984)*/ { //
                                    noSmoothLighting = true;

                                    float NdotE = dot(normalM, eastVec);
                                    if (abs(abs(NdotE) - 0.5) < 0.4) {
                                        #include "/lib/materials/specificMaterials/terrain/openEyeblossom.glsl"
                                    }
                                }
                            } else {
                                if (mat < 10988) { //

                                }
                                else /*if (mat < 10992)*/ { //

                                }
                            }
                        }
                    } else {
                        if (mat < 11008) {
                            if (mat < 11000) {
                                if (mat < 10996) { //

                                }
                                else /*if (mat < 11000)*/ { //

                                }
                            } else {
                                if (mat < 11004) { //

                                }
                                else /*if (mat < 11008)*/ { //

                                }
                            }
                        } else {
                            if (mat < 11016) {
                                if (mat < 11012) { //

                                }
                                else /*if (mat < 11016)*/ { //

                                }
                            } else {
                                if (mat < 11020) { //

                                }
                                else /*if (mat < 11024)*/ { //

                                }
                            }
                        }
                    }
                }
            }
        }
    }
} else {
    if (mat < 11112) { // No Properties Blocks
        isFoliage = false;
    } else if (mat > 20999 && mat < 21025) {
    #ifdef GBUFFERS_TERRAIN
        emission = DoAutomaticEmission(noSmoothLighting, noDirectionalShading, color.rgb, lmCoord.x, blockLightEmission, 1.0);
    #else
        bool doesNothing;
        emission = DoAutomaticEmission(noSmoothLighting, doesNothing, color.rgb, 0.0, 15, 1.0);
    #endif
}
}
}

#ifdef GBUFFERS_TERRAIN
    else { // mat < 10000
        // Support for the Enhanced Block Entities mod. The mod makes block entities render in gbuffers_terrain
        int blockEntityId = mat;
        #include "/lib/materials/materialHandling/blockEntityMaterials.glsl"
    }
#endif