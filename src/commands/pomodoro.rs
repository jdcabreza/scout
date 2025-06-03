use indicatif::{ProgressBar, ProgressStyle};
use std::{thread, time::Duration};
use chrono::Local;

pub fn start_pomodoro(task: &str) {
    let total_secs = 25 * 60; // 25m * 60s
    let progress_bar = ProgressBar::new(total_secs);

    progress_bar.set_style(ProgressStyle::default_bar()
        .template("{msg}\n{bar:40.cyan/blue} {percent}%")
        .unwrap()
        .progress_chars("##-"));

    println!("\n🍅 Pomodoro: {}\n⏳ Focus Time: 25m\n", task);
    println!("\nPress Ctrl+C to exit early.");

    for _ in 0..total_secs {
        progress_bar.set_message(format!(
            "🕒 {} | Task: {}",
            Local::now().format("%H:%M:%S"),
            task
        ));
        progress_bar.inc(1);
        thread::sleep(Duration::from_secs(1));
    }

    progress_bar.finish_with_message("✅ Pomodoro complete! Time for a break.");
}
