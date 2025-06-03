use clap::{CommandFactory, Parser, Subcommand};

#[derive(Parser)] // Autogenerates code to parse CLI args into the Cli struct
#[command(
    name = "Scout", 
    version, 
    about = "Your local AI assistant.", 
    long_about = "Scout is a completely local AI assistant to help you plan out your tasks, meetings, and obligations."
)] // Metadata for --help output
// Root-level interface
struct Cli {
    #[command(subcommand)]
    command: Option<Commands> // Option -> an optional value
    // If there's a value, try to match a value from Commands
}

#[derive(Subcommand)]
// Triple /// is for defining help descriptions
enum Commands {
    /// Manually add a task to your TODOs
    Add,
    /// Mark a task as done
    Done,
    /// Let Scout help you plan your day or week
    Plan,
    /// Let Scout help you review your day or week
    Review,
    /// Show your planned tasks
    Tasks,
}

fn main() {
    // This pulls from std::env::args() behind the scenes
    let cli = Cli::parse();

    match &cli.command {
        Some(Commands::Add) => {
            println!("✍️ Let's add your new task:");
            // Insert adding logic here
        }
        Some(Commands::Done) => {
            println!("🚀 Awesome! Marked that task as done.\n📝 Here are your next tasks:");
            // Insert logic for marking a task as done here
        }
        Some(Commands::Plan) => {
            println!("🧠 Let's start your planning session...");
            // Insert logic for planning here
        }
        Some(Commands::Review) => {
            println!("🔍 Let's review how you did today:");
            // Insert logic for reviewing here
        }
        Some(Commands::Tasks) => {
            println!("📝 Here are your remaining tasks for today:");
            // Insert logic for listing tasks here
        }
        // | None is triggered when no subcommand is given -> default to help
        None => {
            Cli::command().print_help().unwrap();
            println!();
        }
    }
}
