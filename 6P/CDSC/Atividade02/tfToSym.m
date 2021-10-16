function symtf = tfToSym(tf)
    [Num,Den] = tfdata(tf,'v');
    syms s
    symtf = poly2sym(Num,s)/poly2sym(Den,s);
end

