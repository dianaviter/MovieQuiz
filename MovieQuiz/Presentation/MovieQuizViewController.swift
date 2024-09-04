import UIKit

final class MovieQuizViewController: UIViewController {
    
    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet private weak var questionTitleLabel: UILabel!
    @IBOutlet private weak var yesButton: UIButton!
    @IBOutlet private weak var noButton: UIButton!
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if let customFont = UIFont(name: "YSDisplay-Medium", size: 20) {
            yesButton.titleLabel?.font = customFont
            noButton.titleLabel?.font = customFont
        } else {
            print("Failed to load the custom font.")
        }
        questionTitleLabel.font = UIFont(name: "YSDisplay-Medium", size: 20)
        counterLabel.font = UIFont(name: "YSDisplay-Medium", size: 20)
        textLabel.font = UIFont(name: "YSDisplay-Bold", size: 23)
        
        showCurrentQuestion()
    }
    
    struct QuestionShowedViewModel {
        let question: String
        let image: UIImage
        let questionNumber: String
    }
    
    struct QuizResultViewModel {
        let title: String
        let text: String
        let buttonText: String
    }
    
    struct QuestionAnswerViewModel {
        let answer: Bool
    }
    
    struct QuizQuestion {
        let image: String
        let text: String
        let correctAnswer: Bool
    }
    
    private var correctAnswers = 0
    private var currentQuestionIndex = 0
    
    private let question: [QuizQuestion] =
    [QuizQuestion(
        image: "The Godfather",
        text: "Рейтинг этого фильма больше чем 6?",
        correctAnswer: true),
     QuizQuestion(
        image: "The Dark Knight",
        text: "Рейтинг этого фильма больше чем 6?",
        correctAnswer: true),
     QuizQuestion(
        image: "Kill Bill",
        text: "Рейтинг этого фильма больше чем 6?",
        correctAnswer: true),
     QuizQuestion(
        image: "The Avengers",
        text: "Рейтинг этого фильма больше чем 6?",
        correctAnswer: true),
     QuizQuestion(
        image: "Deadpool",
        text: "Рейтинг этого фильма больше чем 6?",
        correctAnswer: true),
     QuizQuestion(
        image: "The Green Knight",
        text: "Рейтинг этого фильма больше чем 6?",
        correctAnswer: true),
     QuizQuestion(
        image: "Old",
        text: "Рейтинг этого фильма больше чем 6?",
        correctAnswer: false),
     QuizQuestion(
        image: "The Ice Age Adventures of Buck Wild",
        text: "Рейтинг этого фильма больше чем 6?",
        correctAnswer: false),
     QuizQuestion(
        image: "Tesla",
        text: "Рейтинг этого фильма больше чем 6?",
        correctAnswer: false),
     QuizQuestion(
        image: "Vivarium",
        text: "Рейтинг этого фильма больше чем 6?",
        correctAnswer: false)
    ]
    
    
    @IBAction private func yesButtonClicked(_ sender: UIButton) {
        showAnswer(answer: true)
    }
    
    
    @IBAction private func noButtonClicked(_ sender: UIButton) {
        showAnswer(answer: false)
    }
    
    private func convert(model: QuizQuestion) -> QuestionShowedViewModel {
        let questionStep = QuestionShowedViewModel (
            question: model.text,
            image: UIImage(named: model.image) ?? UIImage (),
            questionNumber: ("\(currentQuestionIndex + 1)/\(question.count)"))
        return questionStep
    }
    
    private func show (quiz step: QuestionShowedViewModel) {
        textLabel.text = step.question
        imageView.image = step.image
        counterLabel.text = step.questionNumber
    }
    
    private func showCurrentQuestion () {
        let currentQuestion = question [currentQuestionIndex]
        let viewModel = convert(model: currentQuestion)
        show(quiz: viewModel)
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 8
        imageView.layer.cornerRadius = 20
        imageView.layer.borderColor = UIColor.ypBlack.cgColor
    }
    
    private func showAnswer (answer: Bool) {
        let currentQuestion = question [currentQuestionIndex]
        if currentQuestion.correctAnswer == answer {
            imageView.layer.borderColor = UIColor.ypGreen.cgColor
            correctAnswers += 1
        } else {
            imageView.layer.borderColor = UIColor.ypRed.cgColor
        }
        
        currentQuestionIndex += 1
        
        if currentQuestionIndex < question.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.showCurrentQuestion ()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.showResult()
            }
        }
    }
    
    private func showResult () {
        let alert = UIAlertController(title: "Этот раунд окончен!",
                                      message: "Ваш результат \(correctAnswers)/\(question.count)",
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "Сыграть еще раз", style: .default) { _ in
            self.correctAnswers = 0
            self.currentQuestionIndex = 0
            self.showCurrentQuestion()
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}


