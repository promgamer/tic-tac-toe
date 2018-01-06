public class Game
{
    public string next_play(int clicked_cell)
    {
        var label = players[ current_player % 2 ];
        board[clicked_cell] = label;
        current_player++;
        
        return label;
    }
    
    public string calculate_winner()
    {
      int[,] lines = 
      {
        {0, 1, 2},
        {3, 4, 5},
        {6, 7, 8},
        {0, 3, 6},
        {1, 4, 7},
        {2, 5, 8},
        {0, 4, 8},
        {2, 4, 6}
      };
      
      for (int i = 0; i < lines.length[0]; i++)
      {
        var a = lines[i, 0];
        var b = lines[i, 1];
        var c = lines[i, 2];
        
        if (board[a] != "" && board[a] == board[b] && board[a] == board[c])
        {
            return board[a];
        }
      }
      
      return "";
    }
    
    private string[] players = {"X", "O"};
    private string[] board = {"", "", "", "", "", "", "", "", ""};
    private int current_player = 0;
    
    public static int main(string[] args)
    {
        Gtk.init(ref args);

        var builder = new Gtk.Builder.from_file("/usr/local/games/com.github.promgamer.tictactoe/board.glade");
        var window = (Gtk.Widget) builder.get_object ("window1");

        window.destroy.connect (Gtk.main_quit);
        window.show_all ();
        
        var game = new Game();    
        
        for( int i = 0; i < 9; i++ )
        {
            var cell = (Gtk.Button) builder.get_object (i.to_string());
            cell.clicked.connect( () => {
            
                cell.set_sensitive(false);
                
                cell.label = game.next_play(i);
                
                var winner = game.calculate_winner();
                if( winner != "" )
                {
                    cell.label = "GG";
                }
            });
        }

        Gtk.main ();
        return 0;
    } 
}
