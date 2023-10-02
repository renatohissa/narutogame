import UIKit

class MyCharacters: UITableViewCell {
    
    var characters = [Character]()
    var characterImageView = UIImageView()
    var nickTitleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(characterImageView)
        addSubview(nickTitleLabel)
        configureImageView()
        configureTitleLabel()
        setImageConstraints()
        setTitleLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(character: Character) {
        characterImageView.image = character.getImage()
        
        nickTitleLabel.text = character.name
    }
    
    func configureImageView() {
        characterImageView.layer.cornerRadius = 10
        characterImageView.clipsToBounds =  true
    }
    
    func configureTitleLabel() {
        nickTitleLabel.numberOfLines = 0
        nickTitleLabel.adjustsFontSizeToFitWidth = true
    }
    
    func setImageConstraints() {
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        characterImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        characterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        characterImageView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        characterImageView.widthAnchor.constraint(equalTo: characterImageView.heightAnchor, multiplier: 16/9).isActive = true
    }
    
    func setTitleLabelConstraints() {
        nickTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        nickTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        nickTitleLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 20).isActive = true
        nickTitleLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        nickTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }
}
