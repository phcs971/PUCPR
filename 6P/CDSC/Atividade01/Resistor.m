function resistencia = Resistor(cor1, cor2, cor3)
    cores = ["preto", "marrom", "vermelho", "laranja", "amarelo", "verde", "azul", "violeta", "cinza", "branco"];
    if nargin == 3
        A = find(cores==strtrim(lower(cor1)), 1) - 1;
        B = find(cores==strtrim(lower(cor2)), 1) - 1;
        C = find(cores==strtrim(lower(cor3)), 1) - 1;
        if isempty(A)
            fprintf('Erro! Entrada Inválida! Cor "%s" Inválida!\n', cor1)
        elseif isempty(B)
            fprintf('Erro! Entrada Inválida! Cor "%s" Inválida!\n', cor2)
        elseif isempty(C)
            fprintf('Erro! Entrada Inválida! Cor "%s" Inválida!\n', cor3)
        elseif A == 0
            fprintf("Erro! Entrada Inválida! O primeiro anel não pode ser preto!\n")
        else
            resistencia = (10 * A + B) * 10 ^ C / 1000;
            fprintf("Resistência = %d kΩ\n", resistencia);
        end
    else
        fprintf("Erro! Entrada Inválida! Deve se passar três (3) argumentos!\n")
    end
end