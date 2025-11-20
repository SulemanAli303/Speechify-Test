/*
 *****************************************************************************
 *                                                                           *
 *          >>>>>>>>>>>  DO NOT MODIFY THIS FILE  <<<<<<<<<<<                *
 *                                                                           *
 *                YOU WILL AUTOMATICALLY FAIL IF YOU DO!                     *
 *                                                                           *
 *****************************************************************************
 */

import SwiftUI

extension View {
    func execute(_ action: @escaping () -> Void) -> some View {
        DispatchQueue.main.async {
            action()
        }
        return self
    }
}

/*
 *****************************************************************************
 *                   END OF FILE - DO NOT MODIFY ANYTHING!                   *
 *****************************************************************************
 */
