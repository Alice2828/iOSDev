//
//  AboutUsVC.swift
//  KBTUApp
//
//  Created by User on 11.03.2021.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit

class AboutUsVC: UIViewController {

    @IBOutlet weak var textField: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text = "   The idea of creating Kazakh-British Technical University was conceived by the former President of the Republic of Kazakhstan, Nursultan Nazarbayev, who is now the leader of the nation. Further discussions on the establishment of the University were held during President Nazarbayev’s official visit to the United Kingdom in November 2000. A Memorandum of Understanding (MoU) was signed between the officials of the two countries on enhancing cooperation in education, science and technology fields. \n    The Kazakh-British Technical University JSC was established by the Government of the Republic of Kazakhstan on August 03 2001 under Decree No. 1027 and in accordance with the MoU signed between the Ministry of Education and Science of the Republic of Kazakhstan and the British Council. The Ministry represented the Kazakh Government as the founder of the KBTU, while the British Embassy in Kazakhstan and the British Council represented the British side. \n  Since 2003, NC KazMunay Gas JSC has been the sole shareholder of KBTU JSC (Resolution of the Government of the Republic of Kazakhstan No. 987 dated September 26, 2003). However, in 2018, a Public Foundation “Education Fund of Nursultan Nazarbayev” purchased shares of the Kazakh-British Technical University. The privatization took place following the Government of Kazakhstan’s Privatization Program that was approved by a Government’s order No. 1141 on December 30, 2015. \n  The KBTU Institute of Engineering and Information Technologies was established in 2003. The Institute provides advanced training to professionals and staff working in the public and private sectors. \n    Since 2005, KBTU is awarding double undergraduate degrees in partnership with the University of London. Under the program students receive London School of Economics and Political Science and KBTU degrees while studying at the KBTU in Almaty. \n In 2010 – 2011, KBTU received 100 percent shares of two historical and prestigious scientific institutions of Kazakhstan, ‘A.B. Bekturov Institute of Chemical Sciences’ that was founded in 1945 and ‘D.V. Sokolsky Institute of Fuel, Catalysis and Electrochemistry’, which was established in 1969."
         textField.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 0)
    }
}
