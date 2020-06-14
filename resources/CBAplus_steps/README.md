# How to perform CBA+ surface alignment

## Stage 1: Preparation for standard CBA
Follow these steps for running cortex based alignment (CBA) in BrainVoyager v20.4. See [this intorductory documentation](https://www.brainvoyager.com/bv/doc/UsersGuide/CortexBasedAlignment/CortexBasedAlignmentOfSulciAndGyri.html) beforehand if you are unfamiliar with CBA.:

1. [Prepare a mesh for CBA.](https://www.brainvoyager.com/bv/doc/UsersGuide/CortexBasedAlignment/PreparingAMeshForCBA.html).

2. [Morh the mesh to a sphere.](https://www.brainvoyager.com/bv/doc/UsersGuide/CortexBasedAlignment/MorphingAReconstructedCortexHemisphereToASphere.html)

3. [Map the spherical mesh onto the standard sphere mesh.](https://www.brainvoyager.com/bv/doc/UsersGuide/CortexBasedAlignment/MappingTheStandardSphereToAMorphedSphere.html)

4. [Create multi-scale curvature maps.](https://www.brainvoyager.com/bv/doc/UsersGuide/CortexBasedAlignment/CreatingCurvatureMapsForAlignment.html)

## Stage 2: Additional preperation step required for CBA+

5. Draw anatomical priors on meshes.

## Stage 3: Running CBA+
Note that each set of hemispheres are run separately. Which means that we have repeated this process twice.

6. Load each hemisphere.
<img src="run_CBAplus_step1.png" width=800/>

7. Run rigid body alignment to make sure the starting point of CBAplus is optimized. We have used the default parameters as shown in the screenshot below.
<img src="run_CBAplus_step2.png" width=800/>

8. Run CBAplus by using the `fCBA` option and passing the anatomical priors generated in Stage 2. We have used the default parameters as shown in the screenshot below.
<img src="run_CBAplus_step3.png" width=800/>

## Stage 4: Quality control
The quality of the results depend on two major factors (in our experience):
- Quality of the surface meshes generated in Step 1 (e.g. no holes or bridges in the initial reconstructed meshes)
- Initial state of the curvature alignments being optimized (which is the reason why we first run spherical rigid body alignment in Step 7.)
As a minor factor:
- Make sure that the anatomical priors are not very close to each other so that the smoothed representations of them are not overlapping to a high degree (the amount of smoothing is determined by the `nr. smooth. steps` parameter in fCBA section in Step 8).