import UIKit



/// ChatMessageCell
class ChatMessageCell: UITableViewCell {

    private let translateText = UILabel()
    private let personText = UILabel()
    private let bubbleBackgroudView = UIView()
    
    private var personLeadingConstraint: NSLayoutConstraint!
    private var personTrailingConstraint: NSLayoutConstraint!
    private var translateLeadingConstraint: NSLayoutConstraint!
    private var translateTrailingConstraint: NSLayoutConstraint!
    private var bubbleTransLeadingConstraint: NSLayoutConstraint!
    private var bubbleTransTrailingConstraint: NSLayoutConstraint!
    private var bubblePersonLeadingConstraint: NSLayoutConstraint!
    private var bubblePersonTrailingConstraint: NSLayoutConstraint!
    
    var chatMessage: ChatMessage! {
        didSet {
            bubbleBackgroudView.backgroundColor = chatMessage.isIncoming ? UIColor.greenYandex : UIColor.redYandex
            
            translateText.textColor = UIColor.whiteYandex
            translateText.text = chatMessage.transText
            
            personText.text = chatMessage.text
            personText.textColor = UIColor.grayYandex
            
            translateText.sizeToFit()
            personText.sizeToFit()
            
            if chatMessage.isIncoming {
                translateTrailingConstraint.isActive = false
                personTrailingConstraint.isActive = false
                personLeadingConstraint.isActive = true
                translateLeadingConstraint.isActive = true
                personText.textAlignment = .left
                translateText.textAlignment = .left
                if #available(iOS 11.0, *) {
                    bubbleBackgroudView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
                } else {
                    // Fallback on earlier versions
                }
            } else {
                personLeadingConstraint.isActive = false
                translateLeadingConstraint.isActive = false
                personTrailingConstraint.isActive = true
                translateTrailingConstraint.isActive = true
                personText.textAlignment = .right
                translateText.textAlignment = .right
                if #available(iOS 11.0, *) {
                    bubbleBackgroudView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
                } else {
                    // Fallback on earlier versions
                }
            }

            if (translateText.frame.width < personText.frame.width) {
                bubbleTransLeadingConstraint.isActive = false
                bubbleTransTrailingConstraint.isActive = false
                bubblePersonTrailingConstraint.isActive = true
                bubblePersonLeadingConstraint.isActive = true
            } else {
                bubblePersonTrailingConstraint.isActive = false
                bubblePersonLeadingConstraint.isActive = false
                bubbleTransLeadingConstraint.isActive = true
                bubbleTransTrailingConstraint.isActive = true
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        
        bubbleBackgroudView.layer.cornerRadius = 16.0
        
        personText.font = UIFont.systemFont(ofSize: 15.0, weight: UIFont.Weight.medium)
        translateText.font = UIFont.systemFont(ofSize: 20.0, weight: UIFont.Weight.medium)
        translateText.sizeToFit()
        personText.sizeToFit()
        
        bubbleBackgroudView.translatesAutoresizingMaskIntoConstraints = false
        personText.translatesAutoresizingMaskIntoConstraints = false
        translateText.translatesAutoresizingMaskIntoConstraints = false
        
        personText.numberOfLines = 0
        translateText.numberOfLines = 0
        
        addSubview(bubbleBackgroudView)
        addSubview(personText)
        addSubview(translateText)
        
        let constraints = [
            personText.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            personText.widthAnchor.constraint(lessThanOrEqualToConstant: 199),
            
            translateText.topAnchor.constraint(equalTo: personText.bottomAnchor, constant: 2),
            translateText.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
            translateText.widthAnchor.constraint(lessThanOrEqualToConstant: 199),
            
            bubbleBackgroudView.topAnchor.constraint(equalTo: personText.topAnchor, constant: -11),
            bubbleBackgroudView.bottomAnchor.constraint(equalTo: translateText.bottomAnchor, constant: 11)
        ]
        NSLayoutConstraint.activate(constraints)
        
        personLeadingConstraint = translateText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24)
        translateLeadingConstraint = personText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24)
        
        personTrailingConstraint = translateText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24)
        translateTrailingConstraint = personText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24)
        
        bubbleTransLeadingConstraint = bubbleBackgroudView.leadingAnchor.constraint(equalTo: translateText.leadingAnchor, constant: -12)
        bubbleTransTrailingConstraint = bubbleBackgroudView.trailingAnchor.constraint(equalTo: translateText.trailingAnchor, constant: 12)
        bubblePersonLeadingConstraint = bubbleBackgroudView.leadingAnchor.constraint(equalTo: personText.leadingAnchor, constant: -12)
        bubblePersonTrailingConstraint = bubbleBackgroudView.trailingAnchor.constraint(equalTo: personText.trailingAnchor, constant: 12)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
