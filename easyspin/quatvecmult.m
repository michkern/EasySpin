%  quatvecmult Rotate a vector using a quaternion.
%
%  r = quatvecmult(q, v);
%
%  Input:
%     q          4x... array, normalized quaternion
%     v          3x... array, vector
%
%  Output:
%     r          4x... array, normalized quaternion

function r = quatvecmult(q, v)
    
if size(q, 1) ~= 4
  error('Size of first dimension of the quaternion must equal 4.')
end

if size(v, 1) ~= 3
  error('Size of first dimension of the vector must equal 3.')
end

qmag = sum(q.*q, 1);

if any(1.0-qmag(:) > 1e-5)
    error('Input quaternion is not normalized.')
end

qshape = size(q);
qIndex = cell(1, ndims(q));
qIndex(:) = {':'};

qv = zeros(qshape);
qv(2:end, qIndex{2:end}) = v;
qinv = bsxfun(@times,q,[1;-1;-1;-1]);

r = quatmult(quatmult(q, qv), qinv);

r = r(2:end, qIndex{2:end});

end