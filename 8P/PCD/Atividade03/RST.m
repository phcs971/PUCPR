function [R, S, T] = RST(A, B, Ac, Ao)
    Amf = conv(Ac, Ao)';
    syl = [
    [A 0]
    [0 A]
    [B 0 0]
    [0 B 0]
    [0 0 B]
    ]';
    coefs = syl\Amf;
    R = conv([1, -1], [1 coefs(2)]);
    S = [coefs(3) coefs(4) coefs(5)];
    t0 = sum(Ac)/sum(B);
    T = t0 * Ao;
end

