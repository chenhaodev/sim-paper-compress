function h = mytitle(txt)

FS = get(gca, 'FontSize');

h = text(0.5, 0.98, txt, 'units', 'normalized', 'horizontalalignment', 'center', 'verticalalignment', 'top', 'fontsize', FS);

set(h, 'background', 'white')


% Ivan Selesnick
% NYU-Poly
% selesi@poly.edu
