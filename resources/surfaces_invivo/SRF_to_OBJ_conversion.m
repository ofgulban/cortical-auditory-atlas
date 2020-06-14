% BrainVoyager SRF triangular mesh format to Wavefront OBJ format conversion.
%{
Dependencies
------------
1- Neuroelf should be added to Matlab path. Source: http://neuroelf.net/,
tested version: 1.0
2- Resulting file can be loaded to e.g. Meshlab.
%}

clear all;

SRF_FILES = {
'/path/to/brain_surface1.srf'
'/path/to/brain_surface2.srf'
'/path/to/brain_surface3.srf
};
%%
for i=1:length(SRF_FILES)
srf_file = SRF_FILES{i};
add_color = false;
surf_color = [0, 0, 1];
% Read files
srf = xff(srf_file);
% Derivatives
outname = [srf_file(1:end-4), '.obj'];
nr_verts = srf.NrOfVertices;
nr_faces = srf.NrOfTriangles;
coord = srf.VertexCoordinate;
norms = srf.VertexNormal;
color = srf.VertexColor(:, 2:4);
faces = srf.TriangleVertex;

% Write OBJ file (<https://en.wikipedia.org/wiki/Wavefront_.obj_file>)
fid = fopen(outname, 'wt');
fprintf(fid, '# Converted from BrainVoyager SRF format.\n');

% Vertices
for i=1:nr_verts
    if add_color
        fprintf(fid, 'v %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f \n',...
        coord(i, 1), coord(i, 2), coord(i, 3), ...
        surf_color(1), surf_color(2), surf_color(3));  % color here
    elseif sum(color) == 0
        fprintf(fid, 'v %8.4f %8.4f %8.4f \n',...
        coord(i, 1), coord(i, 2), coord(i, 3));
    else
        fprintf(fid, 'v %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f \n',...
        coord(i, 1), coord(i, 2), coord(i, 3), ...
        color(i, 1), color(i, 2), color(i, 3));
    end
end
fprintf(fid, '\n');

% Vertex normals
norms = norms .* -1;  % invert direction
for i=1:nr_verts
    fprintf(fid, 'vn %6.4f %6.4f %6.4f \n', ...
        norms(i, 1), norms(i, 2), norms(i, 3));
end
fprintf(fid, '\n');

% Faces (indices start from 1)
faces = [faces(:, 3), faces(:, 2), faces(:, 1)];  % invert winding
for i=1:nr_faces
    fprintf(fid, 'f %d//%d %d//%d %d//%d \n', ...
        faces(i, 1), faces(i, 1), ...
        faces(i, 2), faces(i, 2), ...
        faces(i, 3), faces(i, 3));
end
fprintf(fid, '\n');

fclose(fid);
disp(outname)

end
disp('Finished.')
