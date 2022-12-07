fn main() {

	// part 1

	let datastream = std::fs::read_to_string("day6.txt").unwrap();
	let mut i = 0;
	while i < datastream.len() {
		let marker = &datastream[i..i + 4];
		if marker.chars().all(|c| marker.chars().filter(|&x| x == c).count() == 1) {
			println!("{}", i + 4);
			i = datastream.len();
		}
		i += 1;
	}

	// part 2

	i = 0;
	while i < datastream.len() {
		let marker = &datastream[i..i + 14];
		if marker.chars().all(|c| marker.chars().filter(|&x| x == c).count() == 1) {
			println!("{}", i + 14);
			i = datastream.len();
		}
		i += 1;
	}
}