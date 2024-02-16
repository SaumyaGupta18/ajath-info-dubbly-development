//
//  SegmentVC.swift
//  Dubbly
//
//  Created by SHASHI'S MAC on 09/02/24.
//

import UIKit

class SegmentVC: UIViewController {

    @IBOutlet weak var segmentedControls: UISegmentedControl!
    
    
    
    private enum Constants {
            static let segmentedControlHeight: CGFloat = 40
            static let underlineViewColor: UIColor = .blue
            static let underlineViewHeight: CGFloat = 2
        }
    
    // Container view of the segmented control
        private lazy var segmentedControlContainerView: UIView = {
            let containerView = UIView()
            containerView.backgroundColor = .clear
            containerView.translatesAutoresizingMaskIntoConstraints = false
            return containerView
        }()
    
    // Customised segmented control
        private lazy var segmentedControl: UISegmentedControl = {
            let segmentedControl = UISegmentedControl()

            // Remove background and divider colors
            segmentedControl.backgroundColor = .clear
            segmentedControl.tintColor = .clear

            // Append segments
            segmentedControl.insertSegment(withTitle: "My Music", at: 0, animated: true)
            segmentedControl.insertSegment(withTitle: "Recent", at: 1, animated: true)
      //      segmentedControl.insertSegment(withTitle: "Third", at: 2, animated: true)

            // Select first segment by default
            segmentedControl.selectedSegmentIndex = 0

            // Change text color and the font of the NOT selected (normal) segment
            segmentedControl.setTitleTextAttributes([
                NSAttributedString.Key.foregroundColor: UIColor.black,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular)], for: .normal)

            // Change text color and the font of the selected segment
            segmentedControl.setTitleTextAttributes([
                NSAttributedString.Key.foregroundColor: UIColor.blue,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)], for: .selected)

            // Set up event handler to get notified when the selected segment changes
            segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)

            // Return false because we will set the constraints with Auto Layout
            segmentedControl.translatesAutoresizingMaskIntoConstraints = false
            return segmentedControl
        }()

    // The underline view below the segmented control
       private lazy var bottomUnderlineView: UIView = {
           let underlineView = UIView()
           underlineView.backgroundColor = Constants.underlineViewColor
           underlineView.translatesAutoresizingMaskIntoConstraints = false
           return underlineView
       }()

       private lazy var leadingDistanceConstraint: NSLayoutConstraint = {
           return bottomUnderlineView.leftAnchor.constraint(equalTo: segmentedControl.leftAnchor)
       }()
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Add subviews to the view hierarchy
               // (both segmentedControl and bottomUnderlineView are subviews of the segmentedControlContainerView)
               view.addSubview(segmentedControlContainerView)
               segmentedControlContainerView.addSubview(segmentedControl)
               segmentedControlContainerView.addSubview(bottomUnderlineView)

               // Constrain the container view to the view controller
               let safeLayoutGuide = self.view.safeAreaLayoutGuide
               NSLayoutConstraint.activate([
                   segmentedControlContainerView.topAnchor.constraint(equalTo: safeLayoutGuide.topAnchor),
                   segmentedControlContainerView.leadingAnchor.constraint(equalTo: safeLayoutGuide.leadingAnchor),
                   segmentedControlContainerView.widthAnchor.constraint(equalTo: safeLayoutGuide.widthAnchor),
                   segmentedControlContainerView.heightAnchor.constraint(equalToConstant: Constants.segmentedControlHeight)
                   ])
        
        
        // Constrain the segmented control to the container view
                NSLayoutConstraint.activate([
                    segmentedControl.topAnchor.constraint(equalTo: segmentedControlContainerView.topAnchor),
                    segmentedControl.leadingAnchor.constraint(equalTo: segmentedControlContainerView.leadingAnchor),
                    segmentedControl.centerXAnchor.constraint(equalTo: segmentedControlContainerView.centerXAnchor),
                    segmentedControl.centerYAnchor.constraint(equalTo: segmentedControlContainerView.centerYAnchor)
                    ])

                // Constrain the underline view relative to the segmented control
                NSLayoutConstraint.activate([
                    bottomUnderlineView.bottomAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
                    bottomUnderlineView.heightAnchor.constraint(equalToConstant: Constants.underlineViewHeight),
                    leadingDistanceConstraint,
                    bottomUnderlineView.widthAnchor.constraint(equalTo: segmentedControl.widthAnchor, multiplier: 1 / CGFloat(segmentedControl.numberOfSegments))
                    ])
        
        
        
    }
    
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
            changeSegmentedControlLinePosition()
        }
    
    // Change position of the underline
       private func changeSegmentedControlLinePosition() {
           let segmentIndex = CGFloat(segmentedControl.selectedSegmentIndex)
           let segmentWidth = segmentedControl.frame.width / CGFloat(segmentedControl.numberOfSegments)
           let leadingDistance = segmentWidth * segmentIndex
           UIView.animate(withDuration: 0.3, animations: { [weak self] in
               self?.leadingDistanceConstraint.constant = leadingDistance
              // self?.layoutIfNeeded()
              // self?.segmentedControls.layoutIfNeeded()
           })
       }
    
    

    @IBAction func segmentedControlDidChange(_ sender: UISegmentedControl){
           // segmentedControl.changeUnderlinePosition()
        }
    
}

