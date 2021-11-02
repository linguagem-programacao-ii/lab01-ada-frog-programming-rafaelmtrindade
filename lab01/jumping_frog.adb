with
    Ada.Text_IO,
    Ada.Strings.Fixed,
    Ada.Integer_Text_IO;
use
    Ada.Text_IO,
    Ada.Strings.Fixed,
    Ada.Integer_Text_IO;

-- Feito no compilador online <https://www.jdoodle.com/execute-ada-online/> usando GNATMAKE 9.1.0.
-- Também funciona no <https://onecompiler.com/ada>, só precisa apagar os links desse comentário.
-- NÃO FUNCIONA no <https://www.tutorialspoint.com/compile_ada_online.php>, não sei o motivo.
procedure jumping_frog is
    String_Buffer : String(1..300) := (others => ' ');
    Sep : String := " ";

    Last_Idx : Natural; -- Serve só pra conseguir usar o Get_Line, deve ter como fazer sem isso.
    Split_Idx : Integer;

    Jump_Height : Integer;
    Num_Pipes : Integer;

    Current_Pipe : Integer;
    Current_Jump : Integer;

    procedure Split_Integer_From_String(Source : in String; Pos: in Integer; Value : out Integer; Remainder: out String) is
        Tmp : String(1..Source'Last);
    begin
        -- separa e extrai o Value - como Integer - do começo da Source até o último caractere antes da Pos,
        -- guardando o que sobrar da Source no Remainder, ignorando o caractere na Pos.
        if Pos = Source'Last then
            Move(Source, Tmp);
        else
            Move(Source(Source'First .. Pos-1), Tmp);
            Move(Source(Pos+1 .. Source'Last), Remainder);
        end if;
        Value := Integer'Value(Tmp);
    end Split_Integer_From_String;

begin
    -- Ler primeira linha e extrair Jump_Height e Num_Pipes como Integers
    Get_Line(Item => String_Buffer, Last => Last_Idx);
    Split_Idx := Index(Source => String_Buffer, Pattern => Sep, From => 1);

    Split_Integer_From_String(Source => String_Buffer, Pos => Split_Idx, Value => Jump_Height, Remainder => String_Buffer);
    Split_Integer_From_String(Source => String_Buffer, Pos => String_Buffer'Last, Value => Num_Pipes, Remainder => String_Buffer);

    -- Ler segunda linha e percorrer cada pipe até perder ou ganhar
    Get_Line(Item => String_Buffer, Last => Last_Idx);

    for I in 1 .. Num_Pipes loop
        Split_Idx := Index(Source => String_Buffer, Pattern => Sep, From => 1);
        Split_Integer_From_String(Source => String_Buffer, Pos => Split_Idx, Value => Current_Jump, Remainder => String_Buffer);

        if I /= 1 and abs(Current_Jump - Current_Pipe) > Jump_Height then
            Put_Line("GAME OVER");
            exit;
        end if;

        Current_Pipe := Current_Jump;

        if I = Num_Pipes then
            Put_Line("YOU WIN");
        end if;
    end loop;
end jumping_frog;