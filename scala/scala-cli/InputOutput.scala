import scala.io.Source
import java.io.PrintWriter

@main def main = {
  val INPUT_FILE_NAME = "input.txt"
  val OUTPUT_FILE_NAME = "output.txt"

  println(s"# Reading ${INPUT_FILE_NAME}:\n")

  for (line <- Source.fromFile(INPUT_FILE_NAME).getLines()) {
    println(s"- ${line}")
  }

  println(s"\n# Writing to ${OUTPUT_FILE_NAME}\n")

  val SEP = util.Properties.lineSeparator;
  
  // https://stackoverflow.com/questions/44102628/why-can-scala-support-this-new-printwriterfilename-writefile-contents
  new PrintWriter(OUTPUT_FILE_NAME) {
    write("Writing line for line" + SEP)
    write("Another line here" + SEP)
    close
  }
}
