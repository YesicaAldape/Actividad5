package me.jmll.io;

import java.io.IOException;
import java.nio.file.DirectoryIteratorException;
import java.nio.file.DirectoryStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;

public class NIO2RecursiveDir {
	public static List<Path> walkDir(Path path, List<Path> paths){		
		try(DirectoryStream<Path> stream = Files.newDirectoryStream(path)){
			for(Path p: stream){
				if (Files.isDirectory(p)){
					walkDir(p, paths);
				}
				paths.add(p);
			}
		} catch (IOException | DirectoryIteratorException ex){
			System.err.format("Error %s: %s", ex.getClass(), ex.getMessage());
		}
		return paths;
	}
}